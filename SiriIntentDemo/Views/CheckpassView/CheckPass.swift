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
    var checkpassViewModel: CheckPassViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        setUser_default()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkpassViewModel = CheckPassViewModel()
        checkpassViewModel?.delegate = self
        checkpassViewModel?.checkloginfirst(passwordView: passwordView)
      
        passwordView.start(enableBiometrics: true)
        passwordView.imgtop.image = UIImage(named: "icon2")
    }
    func setUser_default(){
        if UserDefaults.standard.bool(forKey: "isFirstLaunch") {
        } else {
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
    }
    func showlockscreen() {
        ButtonTapped()
    }
    
    func okBiometric() {
        checkpassViewModel?.handlePassSuccess(passwordView: passwordView, rootview: self)
    }

    func errBiometric() {
        checkpassViewModel?.handlePassFailure(passwordView: passwordView, rootview: self)
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
        checkpassViewModel?.handlePassSuccess(passwordView: passwordView, rootview: self)
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
