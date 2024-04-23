import GoogleMobileAds
import MBSPasswordView
import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // Thêm thuộc tính shared để truy cập từ các view controller khác
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    var window: UIWindow?
    func applicationDidBecomeActive(_ application: UIApplication) {}

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        // Kiểm tra xem đã có dữ liệu trong Realm chưa
        let existingData = RealmManager.shared.getAppItem()
        if existingData.isEmpty {
            for (name, _) in Data.applock {
                let item = Item()
                item.name = name
                RealmManager.shared.addAppItem(item)
            }
        }
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        if #available(iOS 15, *) {
            // MARK: Navigation bar appearance

            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            navigationBarAppearance.shadowColor = .clear // removing navigationbar 1 px bottom border.
            navigationBarAppearance.backgroundColor = UIColor.clear

            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

            // MARK: Tab bar appearance

//            let tabBarAppearance = UITabBarAppearance()
//            tabBarAppearance.configureWithOpaqueBackground()
//            tabBarAppearance.backgroundColor = UIColor.blue
//            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let userInfo = userActivity.userInfo
        let name = userInfo?["name"]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewControllerB = storyboard.instantiateViewController(withIdentifier: "IntentViewController") as? IntentViewController {
            let navController = UINavigationController(rootViewController: viewControllerB)
            navController.modalPresentationStyle = .fullScreen
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
            viewControllerB.updateLable(name as! String)
        }

        return true
    }
}
