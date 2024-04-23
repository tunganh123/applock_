//
//  Change_Language+setup.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//
import Localize_Swift
import Foundation
import UIKit
extension ChangeLanguage {
    func setupview() {
        tbview.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: Data.GradientStart)
        LanguageManager.delegate = self
        tbview.register(UINib(nibName: "CellChangeLanguage", bundle: nil), forCellReuseIdentifier: "CellChangeLanguage")

        // Đặt kiểu chữ đậm cho tiêu đề của UIBarButtonItem
        let boldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20) // Đặt kiểu chữ đậm ở đây
        ]
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(boldTextAttributes, for: .normal)

        adsChangeLanguage = AdsChangeLanguage(rootViewController: self)
        adsChangeLanguage?.delegate = self
    }

    @IBAction func btnrightclick(_ sender: Any) {
        if let language = languagechanged {
            Localize.setCurrentLanguage(language)
            LanguageManager.changeLanguage(to: language)
        }
        performSegue(withIdentifier: "showlock", sender: self)
    }
}
