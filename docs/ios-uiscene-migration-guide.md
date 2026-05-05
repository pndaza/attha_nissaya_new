# iOS UIScene Migration Guide

This guide records the migration used for this app after moving Flutter iOS to the UIScene lifecycle. Use it as a checklist for other projects that need the same update.

## Problem Seen

The app ran on simulator but failed on a physical iPad after launch. After fixing the lifecycle wiring, the device install then failed with:

```text
Failed to verify code signature ... Runner.app/Frameworks/objective_c.framework : 0xe8008014
The executable contains an invalid signature.
```

There were two separate issues:

- The UIScene migration used a manually-created `FlutterEngine` and `FlutterViewController`, while current Flutter templates use `FlutterSceneDelegate` and the implicit Flutter engine.
- Flutter native asset frameworks such as `objective_c.framework` and `sqlite3.framework` were copied into the app with ad-hoc signatures, which a physical iOS device rejects during install.

## Lifecycle Files

Match current Flutter's UIScene template as closely as possible.

### AppDelegate.swift

Use `FlutterImplicitEngineDelegate`. Register plugins and any app-level channels after the implicit engine is initialized.

```swift
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let messenger = engineBridge.applicationRegistrar.messenger()
    // Create custom MethodChannel/EventChannel instances here when needed.
  }
}
```

Do not keep a separate lazy `FlutterEngine` in `AppDelegate` for a normal Flutter app using storyboards and UIScene.

If the app handles URL schemes, keep forwarding to `super` so Flutter plugins can receive the event too:

```swift
override func application(
  _ app: UIApplication,
  open url: URL,
  options: [UIApplication.OpenURLOptionsKey: Any] = [:]
) -> Bool {
  let flutterHandled = super.application(app, open: url, options: options)
  let appHandled = handleDeepLink(url)
  return flutterHandled || appHandled
}
```

### SceneDelegate.swift

Use `FlutterSceneDelegate`.

```swift
import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {

}
```

If the app handles URL schemes at scene level, call `super` first:

```swift
override func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
  super.scene(scene, openURLContexts: URLContexts)

  guard let url = URLContexts.first?.url else { return }
  // Forward to app-specific deep link handling here.
}
```

## Info.plist

Keep the storyboard entries in both the top-level app config and the scene config.

```xml
<key>UIApplicationSceneManifest</key>
<dict>
  <key>UIApplicationSupportsMultipleScenes</key>
  <false/>
  <key>UISceneConfigurations</key>
  <dict>
    <key>UIWindowSceneSessionRoleApplication</key>
    <array>
      <dict>
        <key>UISceneClassName</key>
        <string>UIWindowScene</string>
        <key>UISceneConfigurationName</key>
        <string>flutter</string>
        <key>UISceneDelegateClassName</key>
        <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
        <key>UISceneStoryboardFile</key>
        <string>Main</string>
      </dict>
    </array>
  </dict>
</dict>
<key>UILaunchStoryboardName</key>
<string>LaunchScreen</string>
<key>UIMainStoryboardFile</key>
<string>Main</string>
```

## Native Asset Framework Signing

Some Flutter packages use Dart native assets. In this app the relevant frameworks were:

- `objective_c.framework`
- `sqlite3.framework`

Flutter copied them into `Runner.app/Frameworks`, but they remained ad-hoc signed. Add a Runner target build phase after `Thin Binary` and `[CP] Embed Pods Frameworks` to sign only Flutter native asset frameworks.

Build phase name:

```text
Sign Native Asset Frameworks
```

Script:

```sh
set -e

if [ "${CODE_SIGNING_ALLOWED:-}" = "NO" ]; then
  exit 0
fi

SIGN_IDENTITY="${EXPANDED_CODE_SIGN_IDENTITY:-}"
if [ -z "$SIGN_IDENTITY" ] || [ "$SIGN_IDENTITY" = "-" ]; then
  SIGN_IDENTITY="${CODE_SIGN_IDENTITY:-}"
fi
if [ -z "$SIGN_IDENTITY" ] || [ "$SIGN_IDENTITY" = "-" ]; then
  exit 0
fi

FRAMEWORKS_DIR="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
if [ ! -d "$FRAMEWORKS_DIR" ]; then
  exit 0
fi

for framework in "$FRAMEWORKS_DIR"/*.framework; do
  if [ ! -d "$framework" ] || [ ! -f "$framework/Info.plist" ]; then
    continue
  fi

  identifier=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$framework/Info.plist" 2>/dev/null || true)
  case "$identifier" in
    io.flutter.flutter.native-assets.*)
      echo "Code Signing $framework with Identity $SIGN_IDENTITY"
      /usr/bin/codesign --force --sign "$SIGN_IDENTITY" ${OTHER_CODE_SIGN_FLAGS:-} --preserve-metadata=identifier,entitlements "$framework"
      ;;
  esac
done
```

## Verification

After migration, run:

```sh
plutil -lint ios/Runner/Info.plist
plutil -lint ios/Runner.xcodeproj/project.pbxproj
flutter build ios --debug
flutter install -d <device-id>
```

Check native asset signatures:

```sh
codesign -dv --verbose=4 build/ios/iphoneos/Runner.app/Frameworks/objective_c.framework 2>&1 | grep TeamIdentifier
codesign -dv --verbose=4 build/ios/iphoneos/Runner.app/Frameworks/sqlite3.framework 2>&1 | grep TeamIdentifier
```

Expected result:

```text
TeamIdentifier=<your development team id>
```

If the output says `Signature=adhoc` or `TeamIdentifier=not set`, the app may build but fail to install on a physical device.

## Migration Checklist

1. Add `SceneDelegate.swift` to the Runner target if it is missing.
2. Make `SceneDelegate` subclass `FlutterSceneDelegate`.
3. Make `AppDelegate` conform to `FlutterImplicitEngineDelegate`.
4. Move plugin registration to `didInitializeImplicitFlutterEngine`.
5. Move custom MethodChannel/EventChannel setup to `didInitializeImplicitFlutterEngine` and use `engineBridge.applicationRegistrar.messenger()`.
6. Keep URL handling forwarding to `super`.
7. Add `UIApplicationSceneManifest`, `UISceneStoryboardFile`, and `UIMainStoryboardFile` in `Info.plist`.
8. Add the native asset framework signing build phase if the project embeds Flutter native assets.
9. Verify on a physical device, not only the simulator.
