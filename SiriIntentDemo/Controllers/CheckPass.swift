//
//  CheckPass.swift
//  AppLock
//
//  Created by Tung Anh on 14/09/2023.
//

import LocalAuthentication
import MBSPasswordView
import UIKit

class CheckPass: MBSViewPattern, MBSViewPatternDelegate, SecutityQuestionDelegate, CheckPassViewModelDelegate {
    func showlockscreen() {
        ButtonTapped()
    }
    
    func navigateToLockScreen() {
    }
    
    var checkpassViewModel: CheckPassViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordView.start(enableBiometrics: true)
        checkpassViewModel = CheckPassViewModel()
        checkpassViewModel?.delegate = self
        passwordView.imgtop.image = UIImage(named: "icon2")
        if let a = passwordView.passwordRegistered() {
            let checkString = a[0]
            if checkString != "" {
                passwordView.topView.newPassword = Data.PWrequestPassword.localized()
            }
        } else {
            passwordView.topView.newPassword = Data.PWcreatenewPassword.localized()
        }
    }
    func okBiometric() {
        checkpassViewModel?.handleBiometricSuccess(passwordView: passwordView, rootview: self)
    }

    func errBiometric() {
        if passwordView.topView.newPassword != Data.PWcreatenewPassword.localized() {
        } else {
            let overlay = SecutityQuestionPopUp()
            overlay.delegate = self // Đặt delegate cho overlay
            overlay.appear(sender: self)
            overlay.btncancel.isHidden = true
        }
    }

    func adserr() {
        performSegue(withIdentifier: "ShowLock", sender: self)
    }

    func ChangeQuestion() {
        passwordView.disableState()
    }

    func showsecurityQuestion() {
        if passwordView.isAttemptsLimitReached {
            let overlay = SecutityQuestionPopUp()
            overlay.delegate = self // Đặt delegate cho overlay
            overlay.appear(sender: self)
            overlay.passwordView = passwordView
        }
    }

    func passwordOK(result: [String]) {
        if passwordView.topView.newPassword != Data.PWcreatenewPassword.localized() {
            ButtonTapped()
        } else {
            let overlay = SecutityQuestionPopUp()
            overlay.delegate = self // Đặt delegate cho overlay
            overlay.appear(sender: self)
            overlay.btncancel.isHidden = true
        }
    }

    func ButtonTapped() {
        if interstitialManager.interstitial != nil {
            interstitialManager.interstitial?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        performSegue(withIdentifier: "ShowLock", sender: self)
    }
}
