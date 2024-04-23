//
//  InstructViewModel.swift
//  AppLock
//
//  Created by Tung Anh on 07/10/2023.
//

import Foundation
import UIKit
class InstructViewModel {
    func Openvideo(){
        if let url = URL(string: Data.videoyoutube) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Không thể mở URL")
            }
        }
    }
    func totalStructor()-> Int {
        return  Data.Structor.count
    }
}
