//
//  ViewPermission+Tap.swift
//  SpeedTest
//
//  Created by Tung Anh on 02/02/2024.
//
import Foundation 

extension ViewCheckPermission {
    @IBAction func tapbtn(_ sender: Any) {
        if checkpermissionVM.currentSlideIndex == 0 {
            print("slide 0")
            setupCombine()
            requestLocationPermission()
        } else if checkpermissionVM.currentSlideIndex == 1 {
            print("slide 1")
            requestAttr()
        } else {
            print("slide 2")
            requestLanNetwork()
        }
    }
}
