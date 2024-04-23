//
//  Change_Language + tableView.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//
import Foundation
import Localize_Swift
import UIKit
extension ChangeLanguage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableLanguages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellLanguage = tableView.dequeueReusableCell(withIdentifier: "CellChangeLanguage") as! CellChangeLanguage
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.clear
        cellLanguage.selectedBackgroundView = selectedBackgroundView
        cellLanguage.img1.image = UIImage(named: availableLanguages[indexPath.row])
        cellLanguage.lb.text = availableLanguages[indexPath.row].localized()
        let currentLanguage = Localize.currentLanguage()
        if indexSellected == nil {
            if currentLanguage == availableLanguages[indexPath.row] {
                cellLanguage.img2.alpha = 1
                cellLanguage.view.layer.borderWidth = 2
                cellLanguage.view.layer.borderColor = UIColor.white.cgColor
            }
        } else if indexSellected == indexPath {
            cellLanguage.img2.alpha = 1
            cellLanguage.view.layer.borderWidth = 2
            cellLanguage.view.layer.borderColor = UIColor.white.cgColor
        } else {
            cellLanguage.img2.alpha = 0
            cellLanguage.view.layer.borderWidth = 0
        }
        return cellLanguage
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSellected = indexPath
        languagechanged = availableLanguages[indexPath.row]
        tableView.reloadData()
    }
}
