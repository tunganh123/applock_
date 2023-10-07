//
//  TableViewCell.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 06/09/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var vi: UIStackView!
    @IBOutlet var img1: UIImageView!
    @IBOutlet var lb: UILabel!
    @IBOutlet var lb2: UILabel!
    @IBOutlet var sw: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sw.isOn = false
        let color2 = UIColor(hex: Data.ColorLightBlue)
        sw.onTintColor = color2 // the "on" color
        sw.isUserInteractionEnabled = false
        // Thay đổi kích thước UISwitch
        let scale: CGFloat = 0.8 // Tỷ lệ thay đổi kích thước, có thể thay đổi theo ý muốn
        sw.transform = CGAffineTransform(scaleX: scale, y: scale)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
