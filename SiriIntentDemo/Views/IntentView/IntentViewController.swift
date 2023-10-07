

import MBSPasswordView
import RealmSwift
import UIKit

class IntentViewController: MBSViewPattern, MBSViewPatternDelegate, SecutityQuestionDelegate {
    var urlz: String?
    var intentViewModel: IntentViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        intentViewModel?.setCheckValue(false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        intentViewModel = IntentViewModel()
        intentViewModel?.updateURL(urlz!)
        passwordView.start(enableBiometrics: true)
        passwordView.topView.newPassword = Data.PWrequestPassword.localized()
    }

    func updateLable(_ strTitle: String) {
        urlz = strTitle
        passwordView.imgtop.image = UIImage(named: strTitle)
    }
    func okBiometric() {
        ButtonTapped()
    }

    func errBiometric() {}

    func adserr() {}

    func ChangeQuestion() {
        passwordView.disableState()
    }

    func passwordOK(result: [String]) {
        ButtonTapped()
    }

    func showsecurityQuestion() {
        if passwordView.isAttemptsLimitReached {
            let overlay = SecutityQuestionPopUp()
            overlay.delegate = self // Đặt delegate cho overlay
            overlay.appear(sender: self)
            overlay.passwordView = passwordView
        }
    }

    func ButtonTapped() {
        intentViewModel?.setCheckValue(true)
        intentViewModel?.openApp()
    }
}
