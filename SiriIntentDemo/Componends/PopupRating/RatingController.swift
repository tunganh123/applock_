//
//  RatingController.swift
//
//
//  Created by mohamed al-ghamdi on 17/04/2018.
//  Copyright © 2018 mohamed al-ghamdi. All rights reserved.
//

import UIKit

class RatingController: UIStackView {
    var starsRating = 0
    var starsEmptyPicName =  Data.iconstarempty // change it to your empty star picture name
    var starsFilledPicName =  Data.iconstarfill// change it to your filled star picture name
    override func draw(_ rect: CGRect) {
        let starButtons = subviews.filter { $0 is UIButton }
        var starXPosition: CGFloat = 0.0
        var starTag = 1
        for button in starButtons {
            if let button = button as? UIButton {
                button.setImage(UIImage(named: starsEmptyPicName), for: .normal)
                button.setTitle("", for: .normal)
                button.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
                button.tag = starTag
                starXPosition += 40 + 20 // Kích thước ngôi sao + khoảng cách giữa các ngôi sao
                // Add pan gesture recognizer
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
                button.addGestureRecognizer(panGesture)

                starTag = starTag + 1
            }
        }
        setStarsRating(rating: starsRating)
    }

    func setStarsRating(rating: Int) {
        starsRating = rating
        let stackSubViews = subviews.filter { $0 is UIButton }
        var animations: [() -> Void] = []

        for subView in stackSubViews {
            if let button = subView as? UIButton {
                let animationBlock: () -> Void = {
                    if button.tag > self.starsRating {
                        button.setImage(UIImage(named: self.starsEmptyPicName), for: .normal)
                    } else {
                        button.setImage(UIImage(named: self.starsFilledPicName), for: .normal)
                        if button.tag == self.starsRating {
                            let originalTransform = button.transform
                            let scale: CGFloat = 1.1
                            UIView.animate(withDuration: 0.25, animations: {
                                button.transform = originalTransform.scaledBy(x: scale, y: scale)
                            }) { _ in
                                UIView.animate(withDuration: 0.25) {
                                    button.transform = originalTransform
                                }
                            }
                        }
                    }
                }
                animations.append(animationBlock)
            }
        }

        // Sequentially execute animations
        for (index, animation) in animations.enumerated() {
            if index == animations.count - 1 {
                // For the last animation, use the completion block to reset button transformations
                UIView.animate(withDuration: 0.25, animations: animation, completion: { _ in
                    for subView in stackSubViews {
                        if let button = subView as? UIButton {
                            button.transform = .identity
                        }
                    }
                })
            } else {
                // For other animations, just animate without completion block
                UIView.animate(withDuration: 0.25, animations: animation)
            }
        }
    }

    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard let button = sender.view as? UIButton else {
            return
        }
        // Loại bỏ tất cả các animations đang chạy trên button
        button.layer.removeAllAnimations()
        let location = sender.location(in: self)
        for i in 1 ... 5 {
            let newRating = i
            let starXPosition = CGFloat(i - 1) * (40 + 20) // Kích thước ngôi sao + khoảng cách giữa các ngôi sao
            if location.x >= starXPosition && location.x <= starXPosition + 40 {
                if newRating != starsRating {
                    setStarsRating(rating: newRating)
                }
                break
            } else if location.x < 0 {
               setStarsRating(rating: 0)
                break
            }
        }
    }

    @objc func pressed(sender: UIButton) {
        setStarsRating(rating: sender.tag)
    }
}
