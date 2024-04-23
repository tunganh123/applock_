//
//  Setting.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 11/09/2023.
//
import Localize_Swift
import UIKit
class Setting: GradientBackgroundViewController,  LanguageChangeDelegate, SecutityQuestionDelegate {
    var settingViewModel: SettingViewModel?
    let availableLanguages = Localize.availableLanguages()
    @IBOutlet var tableview: UITableView!
    @IBOutlet var lb: UILabel!
    var emailManager: EmailManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        LanguageManager.delegate = self
        emailManager = EmailManager(viewController: self)
        settingViewModel = SettingViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = Data.titlesetting.localized()
        navigationController?.navigationBar.topItem?.title = ""
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableview.reloadData()
    }

    func languageDidChange() { 
        tableview.reloadData()
    }
    func ButtonTapped() {}
    func ChangeQuestion() {
        settingViewModel?.setQuestion()
    }

}
