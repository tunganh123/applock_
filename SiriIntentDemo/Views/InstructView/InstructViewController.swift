//
//  SecureViewController.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 05/09/2023.
//

import UIKit
class InstructViewController: GradientBackgroundViewController, LanguageChangeDelegate {
    var instructviewmodel: InstructViewModel?
    @IBOutlet var btnwatchvideo: UIButton!
    @IBOutlet var btn: UIButton!
    @IBOutlet var se: UISearchBar!
    @IBOutlet var tbview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupwillappear()
    }

    func languageDidChange() {
        tbview.reloadData()
    }

    @IBAction func btnwatchvideo(_ sender: Any) {
        instructviewmodel?.Openvideo()
    }

    func setupview() {
        instructviewmodel = InstructViewModel()
        LanguageManager.delegate = self
        btnwatchvideo.tintColor = UIColor(hex: Data.ColorLightBlue)
        btnwatchvideo.layer.cornerRadius = 20
        btnwatchvideo.clipsToBounds = true
    }

    func setupwillappear() {
        btnwatchvideo.setTitle(Data.btnwatchvideo.localized(), for: .normal)
        tbview.register(UINib(nibName: "HdCell", bundle: nil), forCellReuseIdentifier: "HdCell")
    }
}
