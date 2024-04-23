//
//  ViewPermission+func.swift
//  SpeedTest
//
//  Created by Tung Anh on 02/02/2024.
//
import AppTrackingTransparency
import CoreLocation
import Foundation
import GoogleMobileAds
import UIKit
import UserMessagingPlatform

extension ViewCheckPermission {
    func requestAttr() {
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: nil) {
            [weak self] requestConsentError in
            guard let self else { return }

            if let consentError = requestConsentError {
                requestatt()
                return print("Error: tunganh \(consentError.localizedDescription)")
            }

            UMPConsentForm.loadAndPresentIfRequired(from: self) {
                [weak self] loadAndPresentError in
                guard let self else { return }

                if let consentError = loadAndPresentError {
                    // Consent gathering failed.
                    return print("Error: \(consentError.localizedDescription)")
                }
                let userStatus = UMPConsentInformation.sharedInstance.consentStatus
                switch userStatus {
                case .obtained:
                    // User has given consent.
                    requestatt()
                    print("User consented to GDPR.")
                case .notRequired:
                    // User has not given consent.
                    requestatt()
                    print("notRequired GDPR.")
                case .required:
                    // User has not given consent.
                    requestatt()
                    print("required GDPR.")
                case .unknown:
                    // Consent status is unknown.
                    requestatt()
                    print("User consent status is unknown.")
                @unknown default:
                    // Handle any future cases that may be introduced.
                    break
                }
                // Consent has been gathered.
                if UMPConsentInformation.sharedInstance.canRequestAds {
                    self.startGoogleMobileAdsSDK()
                }
            }
        }
        if UMPConsentInformation.sharedInstance.canRequestAds {
            startGoogleMobileAdsSDK()
        }
    }

    func requestatt() {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { [self] status in
                switch status {
                case .authorized:
                    // Người dùng đã đồng ý theo dõi
                    print("Người dùng đã đồng ý theo dõi.")
                    DispatchQueue.main.async {
                        shownavi()
                    }
                case .denied:
                    // Người dùng đã từ chối theo dõi
                    print("Người dùng đã từ chối theo dõi.")
                    DispatchQueue.main.async {
                        shownavi()
                    }
                case .notDetermined: DispatchQueue.main.async {
                        shownavi()
                    }
                case .restricted:
                    DispatchQueue.main.async {
                        shownavi()
                    }
                    break
                @unknown default:
                    break
                }
            }
        } else {
            shownavi()
        }
    }

    private func startGoogleMobileAdsSDK() {
        DispatchQueue.main.async {
            guard !self.isMobileAdsStartCalled else { return }

            self.isMobileAdsStartCalled = true

            // Initialize the Google Mobile Ads SDK.
            GADMobileAds.sharedInstance().start()

            // TODO: Request an ad.
            // GADInterstitialAd.load(...)
        }
    }

    func shownavi() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "Navi") as! UINavigationController
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .flipHorizontal
        present(mainVC, animated: true) {}
    }
}
