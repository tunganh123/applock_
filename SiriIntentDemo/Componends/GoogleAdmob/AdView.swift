//
//  AdView.swift
//  AppLock
//
//  Created by Tung Anh on 25/09/2023.
//

import Foundation
import UIKit

class AdView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .white // Đổi màu nền tùy ý
    }
}
