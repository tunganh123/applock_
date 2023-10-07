//
//  ChangePass.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 09/09/2023.
//

import MBSPasswordView
import RealmSwift
import UIKit
class ChangePass: MBSViewPattern, MBSViewPatternDelegate {
    func okBiometric() {}

    func errBiometric() {}

    func showsecurityQuestion() {}

    var checkString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Gọi hàm này mỗi khi màn hình sắp xuất hiện
        passwordView.imgtop.image = UIImage(named: "icon2")
        passwordView.changeExistingPassword()
        passwordView.start(enableBiometrics: false)
    }

    func passwordOK(result: [String]) {
        var alertController: UIAlertController?
        alertController = UIAlertController(
            title: Data.AlertChangePassTitle.localized(),
            message: Data.AlertChangePassMessage.localized(),
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Chuyển sang tab Lock
            self.showlockscreen()
        }
        alertController!.addAction(okAction)
        // Hiển thị thông báo trên màn hình
        present(alertController!, animated: true, completion: nil)
    }

    func adserr() {
        showlockscreen()
    }

    func showlockscreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
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
