//
//  LaunchScreenFile.swift
//  AppLock
//
//  Created by Tung Anh on 21/09/2023.
//
import GoogleMobileAds
import Lottie
import UIKit
class LaunchScreenFile: GradientBackgroundViewController, AppOpenAdManagerDelegate {
    // Chu kỳ sống của quảng cáo app open đã hoàn thành , Có thể đã ok hoặc lỗi
    func appOpenAdManagerAdDidComplete(_ appOpenAdManager: AppOpenAdManager) {
        shownavi()
    }
    @IBOutlet var viewanimate: UIView!
    var animationView: LottieAnimationView!
    @IBOutlet var lbLaunchScreen: UILabel!
    @IBOutlet var splashScreenLabel: UILabel!
    var secondsRemaining: Int = 3
    var countdownTimer: Timer?
    /// Indicates whether the Google Mobile Ads SDK has been intitialized.
    private var isMobileAdsStartCalled = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startTimer()
        setupAnimationView()
        AppOpenAdManager.shared.appOpenAdManagerDelegate = self
        splashScreenLabel.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        lbLaunchScreen.text = Data.lbLaunchScreen.localized()
    }
    @objc func decrementCounter() {
        secondsRemaining -= 1
        guard secondsRemaining <= 0 else {
            splashScreenLabel.text = "App is done loading in: \(secondsRemaining)"
            return
        }
        splashScreenLabel.text = "Done."
        countdownTimer?.invalidate()
        if UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            AppOpenAdManager.shared.showAdIfAvailable(viewController: self)
        } else {
          //  RouteCoordinator.shared.performToCheckPermiss(from: self)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let ViewCheckPermission = storyboard.instantiateViewController(withIdentifier: "Checkpermission") as? ViewCheckPermission else {
                return
            }
            ViewCheckPermission.modalTransitionStyle = .flipHorizontal
            // Hiển thị UITabBarController toàn màn hình
            ViewCheckPermission.modalPresentationStyle = .fullScreen

            // Present UITabBarController
            self.present(ViewCheckPermission, animated: true, completion: nil)
        }
    }

    private func startGoogleMobileAdsSDK() {
        DispatchQueue.main.async {
            guard !self.isMobileAdsStartCalled else { return }
            self.isMobileAdsStartCalled = true
            // Initialize the Google Mobile Ads SDK.
            GADMobileAds.sharedInstance().start()
            // Load an ad.
            AppOpenAdManager.shared.loadAd()
        }
    }

    func startTimer() {
        splashScreenLabel.text = "App is done loading in: \(secondsRemaining)"
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(decrementCounter),
            userInfo: nil,
            repeats: true)
    }
    func setupView() {
        if UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            GoogleMobileAdsConsentManager.shared.gatherConsent(from: self) {
                [weak self] consentError, isConsentGiven in
                guard let self else { return }

                if let consentError {
                    // Consent gathering failed.
                    print("Error: \(consentError.localizedDescription)")
                }

                if isConsentGiven {
                    // Người dùng đã đồng ý cho quảng cáo
                    self.startGoogleMobileAdsSDK()
                }

                // Tiếp tục xử lý sau khi có quyền
                //  self.shownavi()
            }

            //        This sample attempts to load ads using consent obtained in the previous session.
            if GoogleMobileAdsConsentManager.shared.canRequestAds {
                startGoogleMobileAdsSDK()
            }
        }
        
    }
    
    
    func setupAnimationView() {
        animationView = .init(name: "animation_lmsiuffa")
        // Tính toán kích thước mới cho animationView (chúng tôi sử dụng viewanimate.bounds)
        let animationViewWidth = viewanimate.bounds.width / 1.5
        let animationViewHeight = viewanimate.bounds.height
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        viewanimate.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false

        // Constraints cho chiều dài và chiều cao của animationView
        animationView.widthAnchor.constraint(equalToConstant: animationViewWidth).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: animationViewHeight).isActive = true

        // Constraints để đặt animationView chính giữa so với viewanimate
        animationView.centerXAnchor.constraint(equalTo: viewanimate.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: viewanimate.centerYAnchor).isActive = true

        animationView.play()
    }

    func shownavi() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "Navi") as! UINavigationController
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .flipHorizontal
        present(mainVC, animated: true) {}
    }
}
