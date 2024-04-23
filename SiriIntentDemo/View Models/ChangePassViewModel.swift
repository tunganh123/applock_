//
//  ChangePassViewModel.swift
//  AppLock
//
//  Created by Tung Anh on 07/10/2023.
//

import Foundation
import UIKit
class ChangePassViewModel{
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
    func showAlert(rootview: MBSViewPattern){
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
        rootview.present(alertController!, animated: true, completion: nil)
    }
}
