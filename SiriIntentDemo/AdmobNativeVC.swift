//
//  AdmobNativeVC.swift
//  DinoEnglish
//
//  Created by Chu Thai Duong on 10/04/2022.
//

import GoogleMobileAds
import UIKit

class AdmobNativeVC: UIViewController {
    @IBOutlet private var nativeAdmobView: GADNativeAdView!

    var didCloseAdmob: (() -> Void)? = nil

    func loadNativeView(nativeAd: GADNativeAd) {
        nativeAdmobView.nativeAd = nativeAd
        (nativeAdmobView.bodyView as! UILabel).text = nativeAd.body
        (nativeAdmobView.headlineView as! UILabel).text = nativeAd.headline
        (nativeAdmobView.callToActionView as! UIButton).setTitle(nativeAd.callToAction, for: .normal)
        (nativeAdmobView.iconView as! UIImageView).image = nativeAd.icon?.image
    }

    // Action
    @IBAction private func didCloseAdmob(_ sender: Any) {
        didCloseAdmob?()
    }
}
