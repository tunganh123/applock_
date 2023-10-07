//
//  ThemeController+CollectionView.swift
//  AppLock
//
//  Created by Tung Anh on 06/10/2023.
//

import Foundation
import UIKit
extension ThemeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeviewModel.numberOfThemes()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as! CollectionCell
        if indexPath.row != 0 {
            cell.img.image = UIImage(named: themeviewModel.themeName(at: indexPath.row))
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor(hex: Data.GradientStart).cgColor, UIColor(hex: Data.GradientEnd).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            // Đặt frame cho gradient layer bằng với frame của cell
            gradientLayer.frame = cell.bounds
            // Thêm gradient layer vào contentView của cell
            cell.layer.insertSublayer(gradientLayer, at: 0)
        }

        if themeviewModel.getselectedTheme() == "" {
            if indexPath.row == 0 {
                cell.imgchecked.alpha = 1
            }
        } else {
            if themeviewModel.isThemeSelected(at: indexPath.row) {
                cell.imgchecked.alpha = 1
            } else {
                cell.imgchecked.alpha = 0
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Tính toán kích thước của mỗi item sao cho tổng kích thước của item và khoảng cách giữa chúng là 5 điểm
        let numberOfItemsInRow = 3 // Số lượng item trong mỗi hàng
        let spacingBetweenItems: CGFloat = 10 // Khoảng cách giữa các item

        // Tính toán kích thước của mỗi item trong hàng
        let totalSpacing = CGFloat(numberOfItemsInRow - 1) * spacingBetweenItems
        let itemWidth = (collectionView.bounds.width - totalSpacing) / CGFloat(numberOfItemsInRow)
        print(itemWidth)
        return CGSize(width: itemWidth, height: 190) // Thay yourItemHeight bằng chiều cao mong muốn cho mỗi item
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // Gọi lại reloadData để cập nhật lại UICollectionView khi xoay màn hình
        collection.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Lặp qua tất cả các indexPath trong UICollectionView
        for visibleIndexPath in collectionView.indexPathsForVisibleItems {
            // Lấy cell tương ứng với indexPath
            if let cell = collectionView.cellForItem(at: visibleIndexPath) as? CollectionCell {
                // Đặt alpha của imgchecked của cell này thành 0
                cell.imgchecked.alpha = 0
            }
        }

        // Lấy cell được chọn và đặt alpha của imgchecked thành 1
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionCell {
            selectedCell.imgchecked.alpha = 1
            themeviewModel.selectTheme(at: indexPath.row)
        }
    }
}
