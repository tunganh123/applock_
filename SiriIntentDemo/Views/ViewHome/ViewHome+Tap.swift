//
//  ViewHome+Tap.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//
import Foundation
import UIKit
extension lockscreenViewController {
    @IBAction func btnquestion(_ sender: Any) {
        questionButtonTapped()
    }

    @objc func questionButtonTapped() {
        // Khi người dùng click nút "Question" trong overlay
        performSegue(withIdentifier: "Tunganh", sender: self)
    }

    @objc func settingButtonTapped() {
        // Khi người dùng click nút "Question" trong overlay
        performSegue(withIdentifier: "showsettinglock", sender: self)
    }
}
