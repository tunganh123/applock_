//
//  SettingViewModel.swift
//  AppLock
//
//  Created by Tung Anh on 07/10/2023.
//

import Foundation
class SettingViewModel {
    var securityText: String?
    var securityQuestionText: String?
    func showSecurityPopup(rootview: GradientBackgroundViewController) {
        let securityQuestionPopup = SecutityQuestionPopUp()
        securityQuestionPopup.delegate = rootview as? any SecutityQuestionDelegate // Đặt delegate cho overlay
        securityQuestionPopup.appear(sender: rootview)
        securityQuestionPopup.completionHandler = { [weak self] text, questionText in
            // Xử lý giá trị được truyền từ textField và lbQuestion.text ở đây
            self?.securityText = text
            self?.securityQuestionText = questionText
        }
        securityQuestionPopup.btnnext.setTitle(Data.btnchange.localized(), for: .normal)
    }
    func setQuestion() {
        UserdefaultQuestionManager.shared.setQuestionValue(value: securityText!, question: securityQuestionText!)
    }
    func showPopupRating(rootview: Setting){
        let popupRating = PopupRating()
        popupRating.appear(sender: rootview)
        popupRating.completionHandler = {
            popupRating.hide()
        }
        popupRating.completionHandlermail = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                rootview.emailManager?.sendEmail()
            }
        }
    }
}
