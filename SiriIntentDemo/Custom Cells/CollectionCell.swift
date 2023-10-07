//
//  CollectionCell.swift
//  AppLock
//
//  Created by Tung Anh on 15/09/2023.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    @IBOutlet var img: UIImageView!
    @IBOutlet var imgchecked: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgchecked.alpha = 0
    }
}
