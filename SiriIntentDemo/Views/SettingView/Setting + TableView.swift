//
//  Setting + TableView.swift
//  AppLock
//
//  Created by Tung Anh on 07/10/2023.
//

import Foundation
import UIKit
extension Setting: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.datatb.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        // Tạo và cấu hình label cho tiêu đề
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white // Đặt màu trắng cho chữ
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18) // Đặt font và kích cỡ chữ
        titleLabel.text = Data.datatb[section].title.localized() // Thiết lập nội dung của tiêu đề
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        // Cấu hình constraints cho label
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.datatb[section].content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cellsetting", for: indexPath)
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectedBackgroundView
        cell.textLabel?.text = Data.datatb[indexPath.section].content[indexPath.row].localized()
        let image = UIImage(systemName: "chevron.right")
        cell.textLabel?.textColor = AppColor.white_background
        let accessory = UIImageView(frame: CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!))
        accessory.image = image
        // set the color here
        accessory.tintColor = UIColor.white
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView = accessory

        // Tạo một UIView với màu sắc bạn muốn sử dụng cho nét kẻ dưới cùng
        let separatorView = UIView(frame: CGRect(x: (cell.textLabel?.frame.origin.x)!, y: cell.bounds.size.height - 1, width: cell.contentView.bounds.size.width, height: 0.5))
        separatorView.backgroundColor = UIColor.gray
        cell.addSubview(separatorView)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: performSegue(withIdentifier: "ShowHD", sender: self)
            case 1: performSegue(withIdentifier: "ShowTheme", sender: self)
            case 2:
                settingViewModel?.showSecurityPopup(rootview: self)
            case 3: performSegue(withIdentifier: "ShowChange", sender: self)
            case 4: performSegue(withIdentifier: "showChangeLanguage", sender: self)
            default: 
                break
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0: settingViewModel?.showPopupRating(rootview: self)
            case 1: emailManager?.sendEmail()
            case 2:
                let items: [Any] = ["AppLock", URL(string: Data.linkapp)!]

                // Tạo UIActivityViewController với mảng nội dung bạn muốn chia sẻ.
                let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)

                // Nếu bạn muốn hiển thị một popover trên iPad, bạn có thể cấu hình nó như sau:
                if let popoverController = activityViewController.popoverPresentationController {
                    popoverController.sourceView = view // Chỉ định view mà popover sẽ hiển thị từ.
                    popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0) // Chỉ định vị trí của popover.
                    popoverController.permittedArrowDirections = [] // Xóa hướng mũi tên trên popover.
                }

                // Hiển thị UIActivityViewController.
                present(activityViewController, animated: true, completion: nil)
            case 3:
                if let url = URL(string: Data.urlappprivacy) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("Không thể mở URL")
                    }
                }

            default:
                break
            }
        }
    }
}
