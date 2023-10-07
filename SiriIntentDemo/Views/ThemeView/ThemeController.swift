//
//  ThemeController.swift
//  AppLock
//
//  Created by Tung Anh on 15/09/2023.
//
import GoogleMobileAds
import RealmSwift
import UIKit
class ThemeController: GradientBackgroundViewController, GADNativeAdDelegate {
    @IBOutlet var collection: UICollectionView!
    var nativeAdView: GADNativeAdView!
    var nativemanager: NativeManager?
     var themeviewModel: ThemeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        collection.collectionViewLayout = layout
        // Do any additional setup after loading the view.
        nativemanager = NativeManager(rootViewController: self)
        
        themeviewModel = ThemeViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = Data.titleTheme.localized()
    }
}


