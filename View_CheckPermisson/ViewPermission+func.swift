//
//  ViewPermission+func.swift
//  SpeedTest
//
//  Created by Tung Anh on 02/02/2024.
//
import AppTrackingTransparency
import CoreLocation
import Foundation
import MMLanScan
extension ViewCheckPermission {
    func requestLocationPermission() {
        locationManager.delegate = self 
        locationManager.requestWhenInUseAuthorization()
        // Kiểm tra xem dịch vụ vị trí đã được bật hay chưa
        if CLLocationManager.locationServicesEnabled() {
            let status = locationManager.authorizationStatus
            switch status {
            case .notDetermined:
                print(".notDetermined")
                // Chưa quyết định, hiển thị yêu cầu truy cập vị trí
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                print(".restricted")
                // Quyền đã bị từ chối hoặc bị hạn chế, hiển thị cảnh báo hoặc hướng dẫn người dùng mở cài đặt
                checkpermissionVM.handleNextButton()
                showLocationPermissionAlert()
            case .authorizedAlways, .authorizedWhenInUse:
                print(".authorizedAlways")
                checkpermissionVM.handleNextButton()
                // Đã có quyền, không cần làm gì cả
                break
            @unknown default:
                break
            }
        } else {
            // Hiển thị cảnh báo rằng vị trí không được hỗ trợ trên thiết bị
            showLocationNotSupportedAlert()
            checkpermissionVM.handleNextButton()
            print("chưa bật định vị")
        }
    }

    func requestAttr() {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { [self] status in
                switch status {
                case .authorized:
                    // Người dùng đã đồng ý theo dõi
                    print("Người dùng đã đồng ý theo dõi.")
                    DispatchQueue.main.async { [self] in
                        checkpermissionVM.handleNextButton()
                    }
                case .denied:
                    // Người dùng đã từ chối theo dõi
                    print("Người dùng đã từ chối theo dõi.")
                    DispatchQueue.main.async { [self] in
                        checkpermissionVM.handleNextButton()
                    }
                case .notDetermined: DispatchQueue.main.async { [self] in
                        checkpermissionVM.handleNextButton()
                    }
                case .restricted:
                    DispatchQueue.main.async { [self] in
                        checkpermissionVM.handleNextButton()
                    }
                    break
                @unknown default:
                    break
                }
            }
        }
    }

    func requestLanNetwork() {
        lanScanner = MMLANScanner(delegate: self)
        lanScanner.start()
    }

    func showLocationPermissionAlert() {
        print("showLocationPermissionAlert")
    }

    func showLocationNotSupportedAlert() {
        print("showLocationNotSupportedAlert")
        // Hiển thị cảnh báo rằng vị trí không được hỗ trợ trên thiết bị
        // ...
    }
}

extension ViewCheckPermission: MMLANScannerDelegate {
    func lanScanDidFindNewDevice(_ device: MMDevice!) {
        lanScanner.stop()
        RouteCoordinator.shared.performToHomeMain(from: self)
    }

    func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        RouteCoordinator.shared.performToHomeMain(from: self)
        //UserDefaults.standard.set(true, forKey: "isFirstLaunch")
    }

    func lanScanDidFailedToScan() {
        RouteCoordinator.shared.performToHomeMain(from: self)
       // UserDefaults.standard.set(true, forKey: "isFirstLaunch")
    }
}
