//
//  ViewHome+setup.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//
import Foundation
import UIKit
extension lockscreenViewController {
    func setupSearchBar() {
        // Đăng ký lắng nghe sự kiện bàn phím sẽ xuất hiện
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // Đăng ký lắ ng nghe sự kiện bàn phím sẽ ẩn đi
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setupview() {
        // hide keyboard
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))

        addRightBarButtonItems()
        tbview.translatesAutoresizingMaskIntoConstraints = false
        LanguageManager.delegate = self
        navigationController?.navigationBar.tintColor = UIColor.white

        // MARK: - Thiết lập bar BUtton bên trái cùng

        let button = UIButton(type: UIButton.ButtonType.custom)
        // set image for button
        button.setImage(UIImage(named: "icon.png"), for: UIControl.State.normal)
        button.adjustsImageWhenHighlighted = false
        button.frame = CGRectMake(0, 0, 53, 31)
        let barButton = UIBarButtonItem(customView: button)
        // assign button to navigationbar
        navigationItem.leftBarButtonItem = barButton

        // MARK: - Thiết lập adjustsImageWhenHighlighted và font weight cho barButton

        // Đặt kiểu chữ đậm cho tiêu đề của UIBarButtonItem
        let boldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20) // Đặt kiểu chữ đậm ở đây
        ]
        butt.setTitleTextAttributes(boldTextAttributes, for: .normal)
        nativemanager = NativeManager(rootViewController: self)
        nativemanager?.delegate = self

        texttitle.textColor = UIColor(hex: Data.ColorLightBlue)

        // MARK: - Đăng ký cell cho tbview và thiết lập màu cho texttitle

        tbview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tbview.showsVerticalScrollIndicator = false

        // MARK: - Thiết lập màu mặc định cho searchBar

        searchbar.tintColor = UIColor.white
        searchbar.barTintColor = UIColor.white
        searchbar?.updateHeight(height: 48)
        searchbar.setPositionAdjustment(UIOffset(horizontal: 10.0, vertical: 0.0), for: .search)

        if let textField = searchbar.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor.lightGray // Màu chữ
            textField.backgroundColor = UIColor(hex: Data.GradientEnd)
            if let iconView = textField.leftView as? UIImageView {
                iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
                iconView.tintColor = UIColor.lightGray // Màu icon
            }
        }

        // Thiết lập màu trắng cho placeholder của ô tìm kiếm
        if let textField = searchbar.value(forKey: "searchField") as? UITextField {
            let placeholderText = NSAttributedString(string: Data.PlaceholderSearch.localized(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            textField.attributedPlaceholder = placeholderText
        }
    }
}
