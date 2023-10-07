//
//  Copyright 2021 Google LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import GoogleMobileAds
import UIKit
class SplashViewController: UIViewController, GADFullScreenContentDelegate {
    /// Number of seconds remaining to show the app open ad.
    /// This simulates the time needed to load the app.

    private var interstitial: GADInterstitialAd?
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
                                   if let error = error {
                                       print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                       return
                                   }
                                   interstitial = ad
                                   interstitial?.fullScreenContentDelegate = self
                                   interstitial?.present(fromRootViewController: self)
                               })
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        // Quảng cáo đã bị tắt. Bạn có thể thực hiện xử lý tại đây.
        // Ví dụ: Chuyển sang màn hình chính của ứng dụng sau khi quảng cáo tắt.
        startMainScreen()
    }

    func startMainScreen() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "Navi") as! UINavigationController
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.modalTransitionStyle = .flipHorizontal
            self.present(mainVC, animated: true) {
                UIView.animate(withDuration: 1.0, delay: 0.5) {
                    self.view.alpha = 0
                }
            }
        }
    }
}
