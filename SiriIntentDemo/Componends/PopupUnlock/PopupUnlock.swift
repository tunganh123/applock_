//
//  PopupUnlock.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 07/09/2023.
//

import UIKit
class PopupUnlock: UIViewController {
    @IBOutlet var contentView: UIView!
    @IBOutlet var img: UIImageView!
    @IBOutlet var lb1: UILabel!
    @IBOutlet var lb2: UILabel!
    @IBOutlet weak var btnunlock: UIButton!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet var backview: UIView!
    var selectedCell: TableViewCell?
    var index: IndexPath?
    var arr = RealmManager.shared.getAppItem()
    @IBAction func cancel(_ sender: Any) {
        hide()
    }
    
    @IBAction func unlock(_ sender: Any) {
        // Nếu click vào A
        selectedCell?.sw.isOn = false
        selectedCell?.lb2.text = Data.textonLockscreen.localized()
        // MARK: - Update trạng thái vào realm

        let itemclick = RealmManager.shared.getAppItem().filter { it in
            it.name == self.arr[self.index!.row].name
        }.first
        // Lưu vào realm
        RealmManager.shared.updateAppItem(itemclick!, value: false)
        // Lưu vào app Group
        UserDefaultsManager.shared.setAppValue(nameapp: (itemclick?.name)!, click: false)
        hide()
    }

    init() {
        super.init(nibName: "PopupUnlock", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        view.backgroundColor = .clear
        backview.backgroundColor = .black.withAlphaComponent(0.6)
        contentView.backgroundColor = UIColor(hex: Data.BackgroundPopup)
        backview.alpha = 0
        contentView.alpha = 0
        contentView.layer.cornerRadius = 10
    }

    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.backview.alpha = 1
                self.contentView.alpha = 1
            }
        }
    }

    func hide() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
