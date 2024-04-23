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
}

class CheckPassViewModel {
    weak var delegate: CheckPassViewModelDelegate?

    func handlePassSuccess(passwordView: MBSPasswordView, rootview: MBSViewPattern) {
        if passwordView.topView.newPassword != Data.PWcreatenewPassword.localized() {
            delegate?.showlockscreen()
        } else {
            let overlay = SecutityQuestionPopUp()
            overlay.delegate = rootview as? any SecutityQuestionDelegate // Đặt delegate cho overlay
            overlay.appear(sender: rootview)
            overlay.btncancel.isHidden = true
        }
    }

    func handlePassFailure(passwordView: MBSPasswordView, rootview: MBSViewPattern) {
        if passwordView.topView.newPassword != Data.PWcreatenewPassword.localized() {
            // Xử lý trường hợp khi xác thực thất bại như làm gì đó
        } else {
            let overlay = SecutityQuestionPopUp()
            overlay.delegate = rootview as? any SecutityQuestionDelegate // Đặt delegate cho overlay
            overlay.appear(sender: rootview)
            overlay.btncancel.isHidden = true
        }
    }
    
    func checkloginfirst(passwordView: MBSPasswordView){
        if let a = passwordView.passwordRegistered() {
            let checkString = a[0]
            if checkString != "" {
                passwordView.topView.newPassword = Data.PWrequestPassword.localized()
            }
        } else {
            passwordView.topView.newPassword = Data.PWcreatenewPassword.localized()
        }
    }
}
