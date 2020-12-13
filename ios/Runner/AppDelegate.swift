import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
      [UIApplicationL.aunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}