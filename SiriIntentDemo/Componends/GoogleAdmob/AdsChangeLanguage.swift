//
//  AdsChangeLanguage.swift
//  AppLock
//
//  Created by Tung Anh on 04/10/2023.
//
import Foundation
import GoogleMobileAds
protocol AdsChangeLanguageDelegate {
    func didReceive(nativeAd: GADNativeAd)
}

class AdsChangeLanguage: NSObject, GADAdLoaderDelegate, GADNativeAdDelegate, GADNativeAdLoaderDelegate {
    var adLoader: GADAdLoader!
    let adUnitID = Data.IDadsnative
    var delegate: AdsChangeLanguageDelegate?
    var rootViewController: UIViewController
    let adsView = AdView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let viewok = AdView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    var nativeAdView: GADNativeAdView!

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init()
        guard
            let nibObjects = Bundle.main.loadNibNamed("AdsChangeLanguage", owner: nil, options: nil),
            let adView = nibObjects.first as? GADNativeAdView
        else {
            assertionFailure("Could not load nib file for adView")
            return
        }
        setAdView(adView)
        setAdsView()
        loadNativeAd()
    }

    func setAdsView() {
        rootViewController.view.addSubview(adsView)
        // Thiết lập ràng buộc cho adsView
        adsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adsView.leadingAnchor.constraint(equalTo: rootViewController.view.leadingAnchor, constant: 0),
            adsView.trailingAnchor.constraint(equalTo: rootViewController.view.trailingAnchor, constant: 0),
            adsView.bottomAnchor.constraint(equalTo: rootViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            adsView.heightAnchor.constraint(equalToConstant: 200)
        ])

        // Thiết lập các thuộc tính của adsView
        adsView.alpha = 0
        adsView.backgroundColor = UIColor(hex: Data.GradientStart)
        adsView.addSubview(viewok)
        viewok.translatesAutoresizingMaskIntoConstraints = false
        viewok.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            viewok.leadingAnchor.constraint(equalTo: adsView.leadingAnchor, constant: 10),
            viewok.trailingAnchor.constraint(equalTo: adsView.trailingAnchor, constant: -10),
            viewok.centerYAnchor.constraint(equalTo: adsView.centerYAnchor),
            viewok.heightAnchor.constraint(equalToConstant: 180)
        ])
        viewok.backgroundColor = UIColor(hex: Data.GradientEnd)
    }

    func setAdView(_ view: GADNativeAdView) {
        // Remove the previous ad view.
        nativeAdView = view
        viewok.addSubview(nativeAdView)
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nativeAdView.topAnchor.constraint(equalTo: viewok.topAnchor),
            nativeAdView.leadingAnchor.constraint(equalTo: viewok.leadingAnchor),
            nativeAdView.trailingAnchor.constraint(equalTo: viewok.trailingAnchor),
            nativeAdView.bottomAnchor.constraint(equalTo: viewok.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func loadNativeAd() {
        adLoader = GADAdLoader(
            adUnitID: adUnitID, rootViewController: rootViewController,
            adTypes: [.native], options: nil)
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }

    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {}

    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        delegate?.didReceive(nativeAd: nativeAd)
        adsView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.adsView.alpha = 1
            DispatchQueue.main.async { [self] in
                setAdView(nativeAdView)
                // Set ourselves as the native ad delegate to be notified of native ad events.
                nativeAd.delegate = self

                // Populate the native ad view with the native ad assets.
                // The headline and mediaContent are guaranteed to be present in every native ad.
                (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline

                // These assets are not guaranteed to be present. Check that they are before
                // showing or hiding them.
                (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
                nativeAdView.bodyView?.isHidden = nativeAd.body == nil

                (nativeAdView.callToActionView as? UIButton)?.alpha = 1
                (nativeAdView.callToActionView as? UIButton)?.layer.cornerRadius = 20
                (nativeAdView.callToActionView as? UIButton)?.backgroundColor = UIColor.white
                (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
                (nativeAdView.callToActionView as? UIButton)?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) // Đặt font đậm và chiều cao 35 cho title
                (nativeAdView.callToActionView as? UIButton)?.layer.borderWidth = 1
                (nativeAdView.callToActionView as? UIButton)?.layer.borderColor = UIColor.systemBlue.cgColor
                nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

                if let iconImage = nativeAd.icon?.image {
                    // Nếu nativeAd.icon?.image không nil, gán giá trị cho nativeAdView.iconView
                    (nativeAdView.iconView as? UIImageView)?.image = iconImage
                } else {
                    (nativeAdView.bodyView as? UILabel)?.leadingAnchor.constraint(equalTo: nativeAdView.leadingAnchor, constant: 15).isActive = true

                    (nativeAdView.headlineView as? UILabel)?.leadingAnchor.constraint(equalTo: nativeAdView.leadingAnchor, constant: 15).isActive = true
                }
                nativeAdView.iconView?.isHidden = nativeAd.icon == nil

                (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
                nativeAdView.storeView?.isHidden = nativeAd.store == nil

                (nativeAdView.priceView as? UILabel)?.alpha = 1

                (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
                nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

                // In order for the SDK to process touch events properly, user interaction should be disabled.
                nativeAdView.callToActionView?.isUserInteractionEnabled = false

                // Associate the native ad view with the native ad object. This is
                // required to make the ad clickable.
                // Note: this should always be done after populating the ad views.
                nativeAdView.nativeAd = nativeAd
            }
        })
    }
}
