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
        return checkpermissionVM.countCollection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as! CellCollection
        switch indexPath.row { 
        case 0: cell.CS_img.image = UIImage(named: "ic_checkpermit_location")
            cell.lbtop.text = DataConstants.ViewCheckpermission_checkLocationTitle.localized()
            cell.lbbot1.text = DataConstants.ViewCheckpermission_checkLocationtop.localized()
            cell.lbbot2.text = DataConstants.ViewCheckpermission_checkLocationbot.localized()
        case 1: cell.CS_img.image = UIImage(named: "ic_checkpermit_ads")
            cell.lbtop.text = DataConstants.ViewCheckpermission_checkAdsTitle.localized()
            cell.lbbot1.text = DataConstants.ViewCheckpermission_checkAdstop.localized()
            cell.lbbot2.text = DataConstants.ViewCheckpermission_checkAdsbot.localized()
        case 2: cell.CS_img.image = UIImage(named: "ic_checkpermit_lanNetwork")
            cell.lbtop.text = DataConstants.ViewCheckpermission_checkNetworkTitle.localized()
            cell.lbbot1.text = DataConstants.ViewCheckpermission_checkNetworktop.localized()
            cell.lbbot2.text = DataConstants.ViewCheckpermission_checkNetworkbot.localized()
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

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkpermissionVM.scrollViewDidEndDecelerating(offsetX: scrollView.contentOffset.x, collectionViewWidth: scrollView.frame.width)
      
    }
}
