
import Foundation
import UIKit
class IntentViewModel {
    var urlz: String = ""
    func setCheckValue(_ value: Bool) {
        UserDefaultsManager.shared.setCheckValue(value)
    }

    func updateURL(_ strTitle: String) {
        switch strTitle {
        case "Facebook": urlz = "fb"
        case "Messenger": urlz = "fb-messenger"
        case "YouTube": urlz = "youtube"
        case "Zalo": urlz = "zalo"
        case "Messages": urlz = "sms"
        case "Telegram": urlz = "tg"
        case "Gmail": urlz = "googlegmail"
        case "Instagram": urlz = "Instagram"
        case "Tiktok": urlz = "tiktok"
        case "Twitter": urlz = "twitter"
        case "Notes": urlz = "mobilenotes"
        case "Photos": urlz = "photos-redirect"
        case "Google Drive": urlz = "googledrive"
        case "Safari": urlz = "http"
        case "ZaloPay": urlz = "zalopay"
        case "MoMo": urlz = "momo"
        // Các trường hợp khác
        default:
            urlz = ""
        }
    }

    func openApp() {
        guard !urlz.isEmpty else {
            // Xử lý trường hợp không có URL
            return
        }
        let URLString = "\(urlz)://"
        if let okURL = URL(string: URLString), UIApplication.shared.canOpenURL(okURL) {
            UIApplication.shared.open(okURL)
        } else {
            print("Không thể mở ứng dụng")
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let window = appDelegate.window
                if let lockscreenViewController = storyboard.instantiateViewController(withIdentifier: "lockscreenViewController") as? lockscreenViewController {
                    let navController = UINavigationController(rootViewController: lockscreenViewController)
                    navController.modalPresentationStyle = .fullScreen
                    window?.rootViewController = navController
                    window?.makeKeyAndVisible()
                }
            }
        }
    }
}
