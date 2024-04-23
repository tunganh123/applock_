//
//  ViewHome+func.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//
import UIKit
import Foundation
extension lockscreenViewController {
    @objc func handleTap() {
        // Ẩn bàn phím khi người dùng chạm vào view
        view.endEditing(true)
    }
    @objc func keyboardWillShow() {
        if let tapGesture = tapGesture {
            view.addGestureRecognizer(tapGesture)
        }
    }

    @objc func keyboardWillHide() {
        // Ẩn bàn phím khi người dùng chạm vào view
        if let tapGesture = tapGesture {
            view.removeGestureRecognizer(tapGesture)
        }
    }
    func addRightBarButtonItems() {
        let btnQuestion = UIButton(type: .custom)
        btnQuestion.setImage(UIImage(systemName: Data.iconquestion), for: .normal)
        btnQuestion.addTarget(self, action: #selector(questionButtonTapped), for: .touchUpInside)
        let btnSetting = UIButton(type: .custom)
        btnSetting.setImage(UIImage(systemName: Data.iconsetting), for: .normal)
        btnSetting.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        let scale: CGFloat = 1.3
        btnQuestion.transform = CGAffineTransform(scaleX: scale, y: scale)
        btnSetting.transform = CGAffineTransform(scaleX: scale, y: scale)

        let stackview = UIStackView(arrangedSubviews: [btnQuestion, btnSetting])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 20

        let rightBarButton = UIBarButtonItem(customView: stackview)
        navigationItem.rightBarButtonItem = rightBarButton
    }
}
