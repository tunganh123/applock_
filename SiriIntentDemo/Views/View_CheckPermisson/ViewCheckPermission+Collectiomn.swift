//
//  ViewCheckPermission+Collectiomn.swift
//  SpeedTest
//
//  Created by Tung Anh on 02/02/2024.
//

import Foundation
import UIKit
extension ViewCheckPermission: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as! CellCollection
        cell.lbbot1.textColor = AppColor.white_gray_background
        cell.lbbot2.textColor = AppColor.gray_gray_background
        switch indexPath.row {
        case 0:
            cell.lbtop.text = DataConstants.ViewCheckpermission_checkAdsTitle.localized()
            cell.lbbot1.text = DataConstants.ViewCheckpermission_checkAdstop.localized()
            cell.lbbot2.text = DataConstants.ViewCheckpermission_checkAdsbot.localized()
      
        default:
            break
        }
        let italicMediumFont = UIFont.italicSystemFont(ofSize: 16)
        cell.lbbot2.font = italicMediumFont
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

   
}
