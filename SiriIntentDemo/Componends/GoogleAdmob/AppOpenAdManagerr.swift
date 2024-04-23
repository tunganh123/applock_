import GoogleMobileAds

protocol InterstitialManagerDelegate {
    func adDidDismissFullScreenContent()
    func didFailToPresentFullScreenContentWithError()
}

class InterstitialManager: NSObject, GADFullScreenContentDelegate {
    public var interstitial: GADInterstitialAd?
    let request = GADRequest()
    var delegate: InterstitialManagerDelegate?
    override init() {
        super.init()
        loadNativeAd()
    }

    func loadNativeAd() {
        GADInterstitialAd.load(withAdUnitID: Data.IDadsInterstitial,
                               request: request,
                               completionHandler: { [self] ad, error in
                                   if let error = error {
                                       print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                       return
                                   }
                                   interstitial = ad
                                   interstitial?.fullScreenContentDelegate = self
                               })
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        delegate?.adDidDismissFullScreenContent()
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        delegate?.didFailToPresentFullScreenContentWithError()
    }
}

protocol NativeManagerDelegate {
    func didReceive(nativeAd: GADNativeAd)
    func didFailToReceiveAdWithError()
}

class NativeManager: NSObject, GADAdLoaderDelegate, GADNativeAdDelegate, GADNativeAdLoaderDelegate {
    var adLoader: GADAdLoader!
    let adUnitID = Data.IDadsnative
    var delegate: NativeManagerDelegate?
    var rootViewController: UIViewController
    let adsView = AdView(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
    var nativeAdView: GADNativeAdView!

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init()
        guard
            let nibObjects = Bundle.main.loadNibNamed("GADNativeAdView", owner: nil, options: nil),
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
        adsView.translatesAutoresizingMaskIntoConstraints = false
        rootViewController.view.addSubview(adsView)
        adsView.alpha = 0
        adsView.layer.cornerRadius = 10
        adsView.layer.borderWidth = 0.3
        adsView.layer.borderColor = UIColor.lightGray.cgColor
        adsView.backgroundColor = UIColor.clear
        adsView.layer.masksToBounds = true // Đảm bảo hiển thị cornerRadius

        // Cài đặt ràng buộc cho adView
        NSLayoutConstraint.activate([
            adsView.leadingAnchor.constraint(equalTo: rootViewController.view.leadingAnchor, constant: +14),
            adsView.trailingAnchor.constraint(equalTo: rootViewController.view.trailingAnchor, constant: -14),
            adsView.bottomAnchor.constraint(equalTo: rootViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            adsView.heightAnchor.constraint(equalToConstant: 70) // Đặt chiều cao của adView
        ])
    }

    func setAdView(_ view: GADNativeAdView) {
        // Remove the previous ad view.
        nativeAdView = view
        adsView.addSubview(nativeAdView)
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            nativeAdView.topAnchor.constraint(equalTo: adsView.topAnchor),
            nativeAdView.leadingAnchor.constraint(equalTo: adsView.leadingAnchor),
            nativeAdView.trailingAnchor.constraint(equalTo: adsView.trailingAnchor),
            nativeAdView.bottomAnchor.constraint(equalTo: adsView.bottomAnchor)
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

    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        delegate?.didFailToReceiveAdWithError()
    }

    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        delegate?.didReceive(nativeAd: nativeAd)
        adsView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.adsView.alpha = 1
            DispatchQueue.main.async { [self] in
                setAdView(nativeAdView)
                // Set ourselves as the native ad delegate to be notified of native ad events.
                nativeAd.delegate = self
                (nativeAdView.headlineView as? UILabel)?.textColor = AppColor.white_background
                (nativeAdView.advertiserView as? UILabel)?.textColor = AppColor.white_gray_background
                (nativeAdView.bodyView as? UILabel)?.textColor = AppColor.gray_gray_background
                // Populate the native ad view with the native ad assets.
                // The headline and mediaContent are guaranteed to be present in every native ad.
                (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
                // These assets are not guaranteed to be present. Check that they are before
                // showing or hiding them.
                (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
                nativeAdView.bodyView?.isHidden = nativeAd.body == nil
                if let button = (nativeAdView.callToActionView as? UIButton), let callToAction = nativeAd.callToAction {
                    button.alpha = 1
                    // Tạo một đối tượng NSAttributedString với các thuộc tính tùy chỉnh
                    func capitalizeFirstLetter(string: String) -> String {
                        return string.prefix(1).capitalized + string.dropFirst()
                    }

                    // Chuyển đổi chữ cái đầu thành chữ in hoa và giữ lại các chữ cái còn lại không thay đổi
                    let capitalizedCallToAction = capitalizeFirstLetter(string: callToAction.lowercased())

                    // Tạo một đối tượng NSAttributedString với các thuộc tính tùy chỉnh
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.boldSystemFont(ofSize: 10), // Đặt kích thước phông chữ bé hơn (ví dụ: 12)
                        .foregroundColor: UIColor.white // Màu chữ
                    ]

                    let truncatedTitle = truncateTextIfNeeded(capitalizedCallToAction, toFitWidth: 40, withFont: UIFont.boldSystemFont(ofSize: 10))
                    let attributedTitle = NSAttributedString(string: truncatedTitle, attributes: attributes)
                    button.setAttributedTitle(attributedTitle, for: .normal)
                }

                nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
                if let stackView = nativeAdView.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
                    if let iconImage = nativeAd.icon?.image {
                        // Nếu nativeAd.icon?.image không nil, gán giá trị cho nativeAdView.iconView
                        (nativeAdView.iconView as? UIImageView)?.image = iconImage
                    } else {
                        (nativeAdView.bodyView as? UILabel)?.leadingAnchor.constraint(equalTo: nativeAdView.leadingAnchor, constant: 15).isActive = true

                        stackView.leadingAnchor.constraint(equalTo: nativeAdView.leadingAnchor, constant: 15).isActive = true
                    }
                }
                nativeAdView.iconView?.isHidden = nativeAd.icon == nil

                (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
                nativeAdView.storeView?.isHidden = nativeAd.store == nil

                (nativeAdView.priceView as? UILabel)?.layer.cornerRadius = 2
                (nativeAdView.priceView as? UILabel)?.layer.masksToBounds = true
                (nativeAdView.priceView as? UILabel)?.text = "AD"
                (nativeAdView.priceView as? UILabel)?.backgroundColor = UIColor.systemYellow
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
