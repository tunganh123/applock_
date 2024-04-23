//
//  Change_Language+ADS.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//
import GoogleMobileAds
import Foundation
import UIKit
extension ChangeLanguage: LanguageChangeDelegate, AdsChangeLanguageDelegate {
    func didReceive(nativeAd: GADNativeAd) {
        bottomConstraint.isActive = false
        tbview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -181).isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func languageDidChange() {
        tbview.reloadData()
    }
}
