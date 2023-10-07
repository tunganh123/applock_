//
//  MyPasswordView.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 09/09/2023.
//

import Foundation
import MBSPasswordView

public class MyPasswordView: MBSPasswordViewType {
    public static var isBiometricsActivate: Bool = false
    
    public var isShakable: Bool = true
    public var titleToRequestAuthentication: String = "Authenticate to change password"
    
    public func changeExistingPassword() {
        // Định nghĩa logic để thay đổi mật khẩu ở đây
        // Hàm này sẽ được triệu hóa khi bạn gọi nó từ một thể hiện của MyPasswordView
    }
    
    public func start(enableBiometrics: Bool) {
        // Định nghĩa logic để bắt đầu quá trình xác thực bằng sinh trắc học (biometrics)
    }
    
    public static func deviceBiometricsKind() -> KindBiometrics {
        // Định nghĩa logic để xác định loại sinh trắc học (ví dụ: Touch ID hoặc Face ID)
        return .touchID // Hoặc .faceID tùy theo thiết bị và hỗ trợ
    }
}
