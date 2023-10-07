//
//  SecureViewController.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 05/09/2023.
//

import UIKit
class SecureViewController: GradientBackgroundViewController, LanguageChangeDelegate {
    func languageDidChange() {
        tbview.reloadData()
    }

    @IBOutlet var btnwatchvideo: UIButton!
    @IBAction func btnwatchvideo(_ sender: Any) {
        if let url = URL(string: Data.videoyoutube) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Không thể mở URL")
            }
        }
    }

    @IBOutlet var btn: UIButton!
    @IBOutlet var se: UISearchBar!
    @IBOutlet var tbview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LanguageManager.delegate = self
        btnwatchvideo.tintColor = UIColor(hex: Data.ColorLightBlue)
        btnwatchvideo.layer.cornerRadius = 20
        btnwatchvideo.clipsToBounds = true
    }

    override func viewWillAppear(_ animated: Bool) {
        btnwatchvideo.setTitle(Data.btnwatchvideo.localized(), for: .normal)
        tbview.register(UINib(nibName: "HdCell", bundle: nil), forCellReuseIdentifier: "HdCell")
    }
}

extension SecureViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.Structor.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HdCell") as! HdCell
        let selectedCell = UIView()
        selectedCell.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectedCell
        cell.lb1.text = Data.Structor[indexPath.row].lb1.localized()
        cell.lb1.textColor = UIColor(hex: Data.ColorLightBlue)
        cell.lb2.text = Data.Structor[indexPath.row].lb2.localized()
        cell.img1.image = UIImage(named: Data.Structor[indexPath.row].img[0])
        cell.img1.layer.cornerRadius = 10
        cell.img1.clipsToBounds = true // Đảm bảo hình ảnh được hiển thị bên trong khung bo tròn
        cell.img2.image = UIImage(named: Data.Structor[indexPath.row].img[1])
        cell.img2.layer.cornerRadius = 10
        cell.img2.clipsToBounds = true // Đảm bảo hình ảnh được hiển thị bên trong khung bo tròn

        if !Data.Structor[indexPath.row].img[2].isEmpty {
            cell.img3.image = UIImage(named: Data.Structor[indexPath.row].img[2])
        } else {
            cell.img3.image = nil // Đặt hình ảnh thành nil nếu không có dữ liệu để tránh ghi đè
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
}
