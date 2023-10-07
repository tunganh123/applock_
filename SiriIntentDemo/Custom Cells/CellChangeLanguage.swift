//
//  CellChangeLanguage.swift
//  AppLock
//
//  Created by Tung Anh on 19/09/2023.
//

import UIKit

class CellChangeLanguage: UITableViewCell {
    @IBOutlet var img1: UIImageView!
    @IBOutlet var lb: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var img2: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(hex: Data.GradientEnd)
        img2.alpha = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        img2.alpha = 0 // Đặt lại alpha về 0 khi cell được tái sử dụng
        view.layer.borderWidth = 0 // Đặt lại borderWidth về 0 khi cell được tái sử dụng
        view.layer.borderColor = UIColor.clear.cgColor // Đặt lại borderColor về màu trong suốt khi cell được tái sử dụng
    }
}
