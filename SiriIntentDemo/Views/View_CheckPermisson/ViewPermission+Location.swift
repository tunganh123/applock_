//
//  ViewPermission+Location.swift
//  SpeedTest
//
//  Created by Tung Anh on 02/02/2024.
//

import CoreLocation
import Foundation
extension ViewCheckPermission: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Đã cấp quyền, thực hiện công việc cần thiết sau khi có quyền
            print("Người dùng đã đồng ý cấp quyền vị trí.")
            checkpermissionVM.handleNextButton()
        case .denied, .restricted:
            // Quyền đã bị từ chối hoặc hạn chế, thực hiện công việc cần thiết khi bị từ chối
            print("Người dùng đã từ chối cấp quyền vị trí.")
            checkpermissionVM.handleNextButton()
        case .notDetermined:
            print("notDetermined")
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Xử lý khi có lỗi xảy ra
        print("Có lỗi xảy ra khi yêu cầu quyền vị trí: \(error.localizedDescription)")
    }
}
