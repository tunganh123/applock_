//
//  lockscreenViewController.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 05/09/2023.
//
import GoogleMobileAds
import RealmSwift
import UIKit
class lockscreenViewController: GradientBackgroundViewController {
    @IBOutlet var tbview: UITableView!
    @IBOutlet var texttitle: UILabel!
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var btnquestion: UIBarButtonItem!
    @IBOutlet var btnsetting: UIBarButtonItem!
    @IBOutlet var butt: UIBarButtonItem!
    // Gesture
    var tapGesture: UITapGestureRecognizer?
    var arr: Results<Item>? = RealmManager.shared.getAppItem()
    var filteredArray: Results<Item>? = RealmManager.shared.getAppItem()
    var nativeAdView: GADNativeAdView!
    var nativemanager: NativeManager?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        texttitle.text = Data.texttitle.localized()
    }
}
