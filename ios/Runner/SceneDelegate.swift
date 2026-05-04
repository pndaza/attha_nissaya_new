import UIKit
import Flutter

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = FlutterViewController(engine: appDelegate.engine, nibName: nil, bundle: nil)
    window?.makeKeyAndVisible()
  }

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let url = URLContexts.first?.url,
          let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    _ = appDelegate.handleDeepLink(url)
  }

}
