//
//  ChangeLanguage.swift
//  AppLock
//
//  Created by Tung Anh on 19/09/2023.
//
import GoogleMobileAds
import Localize_Swift
import UIKit
class ChangeLanguage: UIViewController, LanguageChangeDelegate, AdsChangeLanguageDelegate {
    func didReceive(nativeAd: GADNativeAd) {
        bottomConstraint.constant = 201 // Cập nhật layout để áp dụng thay đổi
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBOutlet var leftnavi: UIBarButtonItem!
    @IBOutlet var tbview: UITableView!
    @IBOutlet var priceView: UILabel!
    var bottomConstraint: NSLayoutConstraint!

    // ADS
    var adsChangeLanguage: AdsChangeLanguage?

    let availableLanguages = Localize.availableLanguages()
    var languagechanged: String?
    override func viewWillAppear(_ animated: Bool) {
        leftnavi.title = Data.LanguageTitle.localized()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomConstraint = tbview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomConstraint.isActive = true

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

    func languageDidChange() {
        tbview.reloadData()
    }
}

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
        if currentLanguage == availableLanguages[indexPath.row] {
            cellLanguage.img2.alpha = 1
            cellLanguage.view.layer.borderWidth = 2
            cellLanguage.view.layer.borderColor = UIColor.white.cgColor
        }
        return cellLanguage
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellselected = tableView.cellForRow(at: indexPath) as! CellChangeLanguage
        cellselected.img2.alpha = 1
        cellselected.view.layer.borderWidth = 2
        cellselected.view.layer.borderColor = UIColor.white.cgColor
        languagechanged = availableLanguages[indexPath.row]
        // Tắt alpha, borderWidth, và borderColor cho các cell khác nếu cần
        for visibleCellIndexPath in tableView.indexPathsForVisibleRows ?? [] {
            if visibleCellIndexPath != indexPath, let cell = tableView.cellForRow(at: visibleCellIndexPath) as? CellChangeLanguage {
                cell.img2.alpha = 0 // Đặt alpha của các cell khác về 0
                cell.view.layer.borderWidth = 0 // Đặt borderWidth của các cell khác về 0
                // Đặt borderColor của các cell khác về màu khác (nếu cần)
                cell.view.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}
