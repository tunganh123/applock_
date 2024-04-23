//
//  ViewHome+TBview.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//
import RealmSwift
import UIKit
import Foundation
extension lockscreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Lấy ra cell custom
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        // Xoá màu khi người dùng click vào 1 cell
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectedBackgroundView
        // Thiết lập text, img cho cell
        // Kiểm tra thuộc tính 'check' và đặt giá trị cho cell.sw.isOn
        let isChecked = filteredArray![indexPath.row].check
        if isChecked == true {
            cell.sw.isOn = isChecked
            cell.lb2.text = Data.textonUnLockscreen.localized()

        } else {
            cell.sw.isOn = false // Đặt giá trị mặc định nếu không có giá trị 'check'
            cell.lb2.text = Data.textonLockscreen.localized()
        }
        cell.lb.text = filteredArray![indexPath.row].name
        cell.img1.image = UIImage(named: filteredArray![indexPath.row].name!)
        // Tạo kiểu nghiêng cho chuỗi
        cell.lb2.font = UIFont.italicSystemFont(ofSize: 11)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        // Lấy ra ô (cell) đã chọn trong realm
        let itemclick = RealmManager.shared.getAppItem().filter { it in
            it.name == self.filteredArray![indexPath.row].name
        }.first

        if let selectedCell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            if filteredArray![indexPath.row].check == false {
                // Lưu vào realm
                RealmManager.shared.updateAppItem(itemclick!, value: true)
                // Lưu vào app Group
                UserDefaultsManager.shared.setAppValue(nameapp: (itemclick?.name)!, click: true)
                ////////
                selectedCell.lb2.text = Data.textonUnLockscreen.localized()
                selectedCell.sw.isOn = true
                // Hiển thị overLay
                let overlay = PopupViewController()
                overlay.appear(sender: self)
                overlay.lb1.text = filteredArray![indexPath.row].name
                overlay.img.image = UIImage(named: filteredArray![indexPath.row].name!)
                overlay.lb2.text = Data.StructorOpenShortcuts.localized()
                overlay.lb2.font = UIFont.italicSystemFont(ofSize: 18)
                overlay.btn1.setTitle(Data.btnOpenShortcuts.localized(), for: .normal)
                overlay.btncancel.setTitle(Data.btncancel.localized(), for: .normal)
                overlay.question.addTarget(self, action: #selector(questionButtonTapped), for: .touchUpInside)
                // Gán closure để thông báo sự thay đổi giá trị của a

            } else {
                let overlay2 = PopupUnlock()
                overlay2.appear(sender: self)
                overlay2.lb1.text = filteredArray![indexPath.row].name
                overlay2.img.image = UIImage(named: filteredArray![indexPath.row].name!)
                overlay2.lb2.text = Data.StructorUnlock.localized()
                overlay2.btnunlock.setTitle(Data.btnUnlock.localized(), for: .normal)
                overlay2.btncancel.setTitle(Data.btncancel.localized(), for: .normal)
                overlay2.index = indexPath
                overlay2.selectedCell = selectedCell // truyền
            }
        }
    }
}
