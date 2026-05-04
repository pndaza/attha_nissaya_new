import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

  lazy var engine: FlutterEngine = {
    let result = FlutterEngine(name: "mm.pndaza.atthanissaya")
    result.run()
    return result
  }()

  private var methodChannel: FlutterMethodChannel?
  private var eventChannel: FlutterEventChannel?
  private let linkStreamHandler = LinkStreamHandler()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GeneratedPluginRegistrant.register(with: engine)

    let messenger = engine.binaryMessenger

    methodChannel = FlutterMethodChannel(name: "mm.pndaza.atthanissaya/channel", binaryMessenger: messenger)
    eventChannel = FlutterEventChannel(name: "mm.pndaza.atthanissaya/events", binaryMessenger: messenger)

    methodChannel?.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) in
      guard call.method == "initialLink" else {
        result(FlutterMethodNotImplemented)
        return
      }
    })

    eventChannel?.setStreamHandler(linkStreamHandler)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    return linkStreamHandler.handleLink(url.absoluteString)
  }

  func handleDeepLink(_ url: URL) -> Bool {
    return linkStreamHandler.handleLink(url.absoluteString)
  }

}

class LinkStreamHandler: NSObject, FlutterStreamHandler {

  var eventSink: FlutterEventSink?
  var queuedLinks = [String]()

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    queuedLinks.forEach({ events($0) })
    queuedLinks.removeAll()
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    self.eventSink = nil
    return nil
  }

  func handleLink(_ link: String) -> Bool {
    guard let eventSink = eventSink else {
      queuedLinks.append(link)
      return false
    }
    eventSink(link)
    return true
  }
}
