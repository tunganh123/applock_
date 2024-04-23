//
//  ChangeLanguage.swift
//  AppLock
//
//  Created by Tung Anh on 19/09/2023.
//
import Localize_Swift
import UIKit
class ChangeLanguage: UIViewController {
    @IBOutlet var leftnavi: UIBarButtonItem!
    @IBOutlet var tbview: UITableView!
    @IBOutlet var priceView: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var indexSellected: IndexPath?
    // ADS
    var adsChangeLanguage: AdsChangeLanguage?

    let availableLanguages = Localize.availableLanguages()
    var languagechanged: String?
    override func viewWillAppear(_ animated: Bool) {
        leftnavi.title = Data.LanguageTitle.localized()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
    }
}
