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
    var changePassViewModel: ChangePassViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        changePassViewModel = ChangePassViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Gọi hàm này mỗi khi màn hình sắp xuất hiện
        passwordView.imgtop.image = UIImage(named: "icon2")
        passwordView.changeExistingPassword()
        passwordView.start(enableBiometrics: false)
    }

    func passwordOK(result: [String]) {
        changePassViewModel?.showAlert(rootview: self)
    }

    func adserr() {
        changePassViewModel?.showlockscreen()
    }
    
}
