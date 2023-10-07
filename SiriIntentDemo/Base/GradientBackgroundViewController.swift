//
//  GradientBackgroundViewController.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 12/09/2023.
//

import UIKit

class GradientBackgroundViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Cập nhật kích thước của gradient layer khi màn hình xoay
        gradientLayer.frame = CGRect(origin: CGPoint.zero, size: size)
    }

    func configView() {
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(hex: Data.GradientStart).cgColor, UIColor(hex: Data.GradientEnd).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        // Thêm gradient layer vào layer của UIViewController
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
