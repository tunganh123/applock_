//
//  SendMail.swift
//  AppLock
//
//  Created by Tung Anh on 05/10/2023.
//
import MessageUI

class EmailManager: NSObject, MFMailComposeViewControllerDelegate {

    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
    }

    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients([Data.usermail])
            mailComposeVC.setSubject(Data.Mailsubject.localized())
            mailComposeVC.setMessageBody(Data.Mailbody.localized(), isHTML: false)

            viewController?.present(mailComposeVC, animated: true, completion: nil)
        } else {
            // Xử lý trường hợp không thể gửi email trên thiết bị này (ví dụ: không có tài khoản email được cấu hình)
            let alert = UIAlertController(title: Data.ErrMailtitle.localized(), message: Data.ErrMailmessage.localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Data.ErrMailaction.localized(), style: .default, handler: nil))
            viewController?.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - MFMailComposeViewControllerDelegate

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

