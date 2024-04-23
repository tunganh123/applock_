//
//  ViewHome+ADS.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//
import Foundation
import GoogleMobileAds
import RealmSwift
import UIKit
extension lockscreenViewController: LanguageChangeDelegate, GADNativeAdDelegate, NativeManagerDelegate {
    func didReceive(nativeAd: GADNativeAd) {
        // Tìm và tắt ràng buộc cũ
        bottomConstraint.isActive = false
        // update
        tbview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -85).isActive = true
        UIView.animate(withDuration: 0.3) { [self] in
            self.view.layoutIfNeeded()
        }
    }

    func didFailToReceiveAdWithError() {}
    func languageDidChange() {
        tbview.reloadData()
    }
}
