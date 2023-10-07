//
//  PopupViewController.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 07/09/2023.
//

import UIKit
class PopupViewController: UIViewController {
    @IBOutlet var contentView: UIView!
    @IBOutlet var img: UIImageView!
    @IBOutlet var lb1: UILabel!
    @IBOutlet var lb2: UILabel!
    @IBOutlet var backview: UIView!
    @IBOutlet var question: UIButton!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btncancel: UIButton!

    @IBAction func open(_ sender: Any) {
        self.hide()
        if let url = URL(string: "shortcuts://") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Xử lý khi không thể mở ứng dụng Shortcuts (có thể thông báo cho người dùng)
            }
        }
    }

    @IBAction func cancel(_ sender: Any) {
        self.hide()
    }

    init() {
        super.init(nibName: "PopupViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
    }

    private func configView() {
        self.view.backgroundColor = .clear
        view.backgroundColor = .clear
        self.backview.backgroundColor = .black.withAlphaComponent(0.6)
        self.contentView.backgroundColor = UIColor(hex: Data.BackgroundPopup)
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
        self.question.layer.borderWidth = 2
        self.question.layer.borderColor = UIColor.black.cgColor
        self.question.layer.cornerRadius = self.question.frame.height / 2
    }

    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.contentView.alpha = 1
            self.backview.alpha = 1
        }
    }

    @IBAction func hi(_ sender: Any) {
        self.hide()
    }

    func hide() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
