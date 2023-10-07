//
//  MKBtn.swift
//  Safe Photos
//
//  Created by Mayckon Barbosa da Silva on 9/16/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import UIKit
 
public class MBSButton: UIButton {
    var textColor: UIColor = .white
    var customBackgroundColor: UIColor = .init(hex: "ffffff").withAlphaComponent(0.1)
    var customBordercolor: UIColor? = .clear
    private var container: UIView?

    override public func draw(_ rect: CGRect) {
        // provide custom style
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        setTitleColor(textColor, for: .normal)
        setTitleColor(UIColor.black, for: .highlighted)
        backgroundColor = isHighlighted ? textColor : customBackgroundColor
        layer.borderWidth = 0.5
        layer.borderColor = customBordercolor?.cgColor
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
