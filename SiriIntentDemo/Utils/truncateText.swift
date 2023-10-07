//
//  truncateText.swift
//  AppLock
//
//  Created by Tung Anh on 04/10/2023.
//

import Foundation
import UIKit
func truncateTextIfNeeded(_ text: String, toFitWidth maxWidth: CGFloat, withFont font: UIFont) -> String {
    let titleSize = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    if titleSize.width > maxWidth {
        let ellipsis = ".."
        let availableWidth = maxWidth - (ellipsis as NSString).size(withAttributes: [NSAttributedString.Key.font: font]).width
        var truncatedText = text
        while (truncatedText as NSString).size(withAttributes: [NSAttributedString.Key.font: font]).width > availableWidth {
            truncatedText = String(truncatedText.dropLast())
        }
        return truncatedText.trimmingCharacters(in: .whitespaces) + ellipsis
    }
    return text
}
