//
//  UIView+Extension.swift
//  tip-calculator
//
//  Created by Kelvin Fok on 15/12/22.
//

import Foundation
import UIKit
extension UIView {
    func addShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 4, height: 4), radius: CGFloat = 4) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }

    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

    func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }

    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    enum ViewBorder: String {
        case Left
        case Right
        case Top
        case Bottom
    }

    func addBorder(vBorders: [ViewBorder], color: UIColor, width: CGFloat) {
        for vBorder in vBorders {
            let borderView = UIView()
            borderView.backgroundColor = color
            borderView.translatesAutoresizingMaskIntoConstraints = false
            borderView.tag = vBorder.rawValue.hashValue // Gán tag để có thể tìm kiếm view theo border type

            switch vBorder {
            case .Left:
                addSubview(borderView)
                NSLayoutConstraint.activate([
                    borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    borderView.topAnchor.constraint(equalTo: topAnchor),
                    borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    borderView.widthAnchor.constraint(equalToConstant: width)
                ])
            case .Right:
                addSubview(borderView)
                NSLayoutConstraint.activate([
                    borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    borderView.topAnchor.constraint(equalTo: topAnchor),
                    borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    borderView.widthAnchor.constraint(equalToConstant: width)
                ])
            case .Top:
                addSubview(borderView)
                NSLayoutConstraint.activate([
                    borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    borderView.topAnchor.constraint(equalTo: topAnchor),
                    borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    borderView.heightAnchor.constraint(equalToConstant: width)
                ])
            case .Bottom:
                addSubview(borderView)
                NSLayoutConstraint.activate([
                    borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    borderView.heightAnchor.constraint(equalToConstant: width)
                ])
            }
        }
    }

    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [
            NSValue(cgPoint: CGPoint(x: center.x - 5, y: center.y)),
            NSValue(cgPoint: CGPoint(x: center.x + 5, y: center.y))
        ]
        animation.autoreverses = true
        animation.repeatCount = Float.infinity // Lặp vô hạn
        animation.duration = 0.1

        layer.add(animation, forKey: "position")
    }
}
