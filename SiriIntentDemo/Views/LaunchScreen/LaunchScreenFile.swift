//
//  LaunchScreenFile.swift
//  AppLock
//
//  Created by Tung Anh on 21/09/2023.
//
import GoogleMobileAds
import Lottie
import UIKit
class LaunchScreenFile: GradientBackgroundViewController {
    @IBOutlet var viewanimate: UIView!
    var animationView: LottieAnimationView!
    @IBOutlet var lbLaunchScreen: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.shownavi()
        }
        setupAnimationView()
    }

    override func viewWillAppear(_ animated: Bool) {
        lbLaunchScreen.text = Data.lbLaunchScreen.localized()
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
