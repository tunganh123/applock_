//
//  ViewCheckPermission.swift
//  SpeedTest
//
//  Created by Tung Anh on 02/02/2024.
//
import AppTrackingTransparency
import CoreLocation
import UIKit
class ViewCheckPermission: GradientBackgroundViewController {
    let locationManager = CLLocationManager()
    @IBOutlet var clview: UICollectionView!
    @IBOutlet var Ins_btn: UIButton!
    var trackingAuthorizationStatus: ATTrackingManager.AuthorizationStatus?
    var isMobileAdsStartCalled = false

    @IBOutlet var bview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Ins_btn.layer.borderColor = UIColor(hex: Data.ColorWhite).withAlphaComponent(0.8).cgColor
        Ins_btn.layer.borderWidth = 0.2
        Ins_btn.addCornerRadius(radius: 7)
        Ins_btn.setTitleColor(UIColor(hex: Data.ColorWhite), for: .normal)
        Ins_btn.setTitle(DataConstants.View_Check_permition_btn.localized(), for: .normal)
    }

    @IBAction func btn_tap(_ sender: Any) {
        requestAttr()
    }
}
