//
//  lockscreenViewController.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 05/09/2023.
//
import GoogleMobileAds
import RealmSwift
import UIKit
class lockscreenViewController: GradientBackgroundViewController, LanguageChangeDelegate, GADNativeAdDelegate, NativeManagerDelegate {
    func didReceive(nativeAd: GADNativeAd) {
        bottomConstraint.constant = 85 // Cập nhật layout để áp dụng thay đổi
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    func didFailToReceiveAdWithError() {}
    @IBOutlet var tbview: UITableView!
    func languageDidChange() {
        tbview.reloadData()
    }
    @IBOutlet var texttitle: UILabel!
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var btnquestion: UIBarButtonItem!
    @IBOutlet var btnsetting: UIBarButtonItem!
    @IBOutlet var butt: UIBarButtonItem!
    @IBAction func btnquestion(_ sender: Any) {
        questionButtonTapped()
    }
    var arr: Results<Item>? = RealmManager.shared.getAppItem()
    var filteredArray: Results<Item>? = RealmManager.shared.getAppItem()
    var nativeAdView: GADNativeAdView!
    var nativemanager: NativeManager?
    var bottomConstraint: NSLayoutConstraint!
    func addRightBarButtonItems() {
        let btnQuestion = UIButton(type: .custom)
        btnQuestion.setImage(UIImage(systemName: Data.iconquestion), for: .normal)
        btnQuestion.addTarget(self, action: #selector(questionButtonTapped), for: .touchUpInside)
        let btnSetting = UIButton(type: .custom)
        btnSetting.setImage(UIImage(systemName: Data.iconsetting), for: .normal)
        btnSetting.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        let scale: CGFloat = 1.3
        btnQuestion.transform = CGAffineTransform(scaleX: scale, y: scale)
        btnSetting.transform = CGAffineTransform(scaleX: scale, y: scale)

        let stackview = UIStackView(arrangedSubviews: [btnQuestion, btnSetting])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 20

        let rightBarButton = UIBarButtonItem(customView: stackview)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        addRightBarButtonItems()
        tbview.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraint = tbview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomConstraint.isActive = true
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
    }
    override func viewWillAppear(_ animated: Bool) {
        texttitle.text = Data.texttitle.localized()
        texttitle.textColor = UIColor(hex: Data.ColorLightBlue)

        // MARK: - Đăng ký cell cho tbview và thiết lập màu cho texttitle

        tbview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

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
    @IBAction func addbtn(_ sender: Any) {
        let alert = UIAlertController(title: "Thông báo", message: "Đây là một thông báo đơn giản", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Nhập thông tin"
            textField.keyboardType = .default
        }

        // Tạo hành động (action) cho thông báo
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            if let textFields = alert.textFields, let text = textFields[0].text {
                let URLString = "\(text)://"
                if let okURL = URL(string: URLString) {
                    if UIApplication.shared.canOpenURL(okURL) {
                        UIApplication.shared.open(okURL)
                    } else {
                        print("K thể mở ứng dụng")
                    }
                }
            }

        })

        // Thêm hành động vào thông báo
        alert.addAction(okAction)
        // Hiển thị thông báo
        present(alert, animated: true, completion: nil)
    }
    @objc func questionButtonTapped() {
        // Khi người dùng click nút "Question" trong overlay
        performSegue(withIdentifier: "Tunganh", sender: self)
    }
    @objc func settingButtonTapped() {
        // Khi người dùng click nút "Question" trong overlay
        performSegue(withIdentifier: "showsettinglock", sender: self)
    }
}

// MARK: - table view
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
extension lockscreenViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    {
        if searchText.count == 0 {
            filteredArray = arr // Nếu searchText rỗng, hiển thị danh sách ban đầu
        } else {
            // Chuyển đổi LazyFilterSequence thành Results<Item>
            filteredArray = arr!.where {
                $0.name.contains(searchText, options: .caseInsensitive)
            }
        }
        tbview.reloadData()
    }
}
