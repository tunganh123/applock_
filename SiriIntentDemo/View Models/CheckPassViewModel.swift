//
//  CheckPassViewModel.swift
//  AppLock
//
//  Created by Tung Anh on 07/10/2023.
//

import Foundation
import MBSPasswordView
import UIKit
protocol CheckPassViewModelDelegate: AnyObject {
    func showlockscreen()
    func navigateToLockScreen()
}

class CheckPassViewModel {
    weak var delegate: CheckPassViewModelDelegate?

    func handleBiometricSuccess(passwordView: MBSPasswordView, rootview: MBSViewPattern) {
        if passwordView.topView.newPassword != Data.PWcreatenewPassword.localized() {
            delegate?.showlockscreen()
        } else {
            let overlay = SecutityQuestionPopUp()
            overlay.delegate = rootview as? any SecutityQuestionDelegate // Đặt delegate cho overlay
            overlay.appear(sender: rootview)
            overlay.btncancel.isHidden = true
        }
    }

    func handleBiometricFailure(passwordView: MBSPasswordView) {
        if passwordView.topView.newPassword != Data.PWcreatenewPassword.localized() {
            // Xử lý trường hợp khi xác thực thất bại như làm gì đó
        } else {
            // Hiển thị popup bảo mật
            // ...
        }
    }

    func handleAdsError() {
        delegate?.navigateToLockScreen()
    }

    func handlePasswordOK(passwordView: MBSPasswordView) {
        if passwordView.topView.newPassword != Data.PWcreatenewPassword.localized() {
            delegate?.showlockscreen()
        } else {
            // Hiển thị popup bảo mật
            // ...
        }
    }
}
