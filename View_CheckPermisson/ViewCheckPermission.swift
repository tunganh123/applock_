//
//  ViewCheckPermission.swift
//  SpeedTest
//
//  Created by Tung Anh on 02/02/2024.
//
import AppTrackingTransparency
import Combine
import CoreLocation
import MMLanScan
import PageControls
import UIKit
class ViewCheckPermission: UIViewController {
    let locationManager = CLLocationManager()
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var clview: UICollectionView!
    @IBOutlet var Ins_btn: UIButton!
    var lanScanner: MMLANScanner!
    var trackingAuthorizationStatus: ATTrackingManager.AuthorizationStatus?
    // InStructVM
    let checkpermissionVM = CheckpermissionVM.shared
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet weak var bview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Ins_btn.layer.borderColor = AppColor.white_background.withAlphaComponent(0.8).cgColor
        Ins_btn.layer.borderWidth = 0.2
        Ins_btn.addCornerRadius(radius: 7)
        Ins_btn.setTitleColor(AppColor.white_background, for: .normal)
        Ins_btn.setTitle(DataConstants.View_Check_permition_btn.localized(), for: .normal)
        pageControl.currentPageIndicatorTintColor = AppColor.color_pageControl
        bview.backgroundColor = AppColor.black_background.withAlphaComponent(0.6)
    }

    func setupCombine() {
        checkpermissionVM.$currentSlideIndex.sink { [self] currentPage in
            pageControl.currentPage = currentPage
            let indexPath = IndexPath(item: currentPage, section: 0)
            print("indexPath", indexPath)
            clview.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }.store(in: &cancellables)
    }
}


