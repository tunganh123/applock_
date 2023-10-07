
//
//  MBSViewPattern.swift
//  AppLock
//
//  Created by Tung Anh on 16/09/2023.
//

import GoogleMobileAds
import MBSPasswordView
import UIKit
protocol MBSViewPatternDelegate: AnyObject {
    func passwordOK(result: [String])
    func showsecurityQuestion()
    func adserr()
    func okBiometric()
    func errBiometric()
}

class MBSViewPattern: UIViewController, GADFullScreenContentDelegate, InterstitialManagerDelegate {
    func adDidDismissFullScreenContent() {}
    func didFailToPresentFullScreenContentWithError() {}
    @IBOutlet var callToActionView: UIButton!
    @IBOutlet var priceView: UILabel!
    var passwordView = MBSPasswordView()
    weak var delegate: MBSViewPatternDelegate?
    let gradientLayer = CAGradientLayer()

    // ADS
    var nativemanager: NativeManager?
    let interstitialManager = InterstitialManager()
    override func viewDidLoad() {
        super.viewDidLoad()
       configView()
    }

    override func viewWillAppear(_ animated: Bool) {
        configViewwillappear()
    }
    func configView() {
        passwordView.delegate = self
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(hex: Data.GradientStart).cgColor, UIColor(hex: Data.GradientEnd).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        // Thêm gradient layer vào layer của UIViewController
        passwordView.bodyView.backgroundColor = UIColor.clear
        passwordView.topView.backgroundColor = UIColor.clear
        passwordView.ViewContent.layer.insertSublayer(gradientLayer, at: 0)
       
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordView)
        // Cài đặt ràng buộc
        passwordView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        passwordView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        interstitialManager.delegate = self
        nativemanager = NativeManager(rootViewController: self)

        let themesave = RealmManager.shared.getThemeItem()
        let theme = themesave.first
        if let themeimg = theme?.themename {
            passwordView.IMG.image = UIImage(named: themeimg)
            passwordView.bodyView.btnBackgroundColor = UIColor(hex: Data.ColorWhite).withAlphaComponent(0.25)
            passwordView.bodyView.btnborderColor = UIColor(hex: Data.ColorWhite).withAlphaComponent(0.4)
            nativemanager?.adsView.backgroundColor =  UIColor(hex: Data.ColorWhite).withAlphaComponent(0.25)
            nativemanager?.adsView.layer.borderWidth = 0.5
            nativemanager?.adsView.layer.borderColor =  UIColor(hex: Data.ColorWhite).withAlphaComponent(0.25).cgColor
        }
        passwordView.btndelete.backgroundColor = .clear
        passwordView.btndelete.layer.borderColor = .none
        
    }
    func configViewwillappear(){
        passwordView.topView.confirmNewPassword = Data.PWconfirmNewPassword.localized()
        passwordView.topView.currentPassword = Data.PWcurrentPassword.localized()
        passwordView.topView.newPassword = Data.PWnewPassword.localized()
        passwordView.topView.requestPassword = Data.PWrequestPassword.localized()
        passwordView.topView.tryAgainIn = Data.PWtryAgainIn.localized()
    }
}

extension MBSViewPattern: MBSPasswordDelegate {
    func wrongPassword(_ result: InvalidPasswordResult) {
        delegate?.showsecurityQuestion()
    }

    func password(_ result: [String]) { // optional
        delegate?.passwordOK(result: result)
    }

    func passwordFromBiometrics(_ result: MBSPasswordResult<[String]>) {
        switch result {
            case .success(let values):
                delegate?.okBiometric()
            case .error(let error):
                if let error = error {
                    delegate?.errBiometric()
                } else {
                    print("Unknown error occurred")
                }
        }
    }
}
