//
//  TopViewController.swift
//  AppLock
//
//  Created by Tung Anh on 23/09/2023.
//

import UIKit
import MBSPasswordView
class TopViewController: UIViewController {
    var ToppasswordView = MBSTopPasswordView()
    override func viewDidLoad() {
        super.viewDidLoad()
        ToppasswordView.delegate = self
        // Do any additional setup after loading the view.
    }
    

}
extension TopViewController: MBSTopPasswordDelegate {
    func password(_ result: [String]) {
        print(result)
    }
    
    func invalidMatch(_ result: InvalidPasswordResult) {
//        passwordView.bodyView.backgroundColor = UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1.00)
    }

    func resetbg() {
        // Trả lại màu nền ban đầu cho bodyView
//        passwordView.bodyView.backgroundColor = UIColor.clear
    }
}
