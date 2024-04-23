//
//  PopupRating.swift
//  AppLock
//
//  Created by Tung Anh on 05/10/2023.
//

import UIKit

class PopupRating: UIViewController {
    @IBOutlet var backview: UIView!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var lbtitle: UILabel!
    @IBOutlet var lbInstruct: UILabel!
    @IBOutlet var StackRating: RatingController!
    @IBOutlet var btnlater: UIButton!
    @IBOutlet var btnrate: UIButton!
    @IBOutlet var viewtop: UIView!
    var completionHandler: (() -> Void)?
    var completionHandlermail: (() -> Void)?
    init() {
        super.init(nibName: "PopupRating", bundle: nil)
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
        lbtitle.text = Data.Ratingtitle.localized()
        lbInstruct.text = Data.Ratingbody.localized()
        btnlater.setTitle(Data.Ratingbtnlater.localized(), for: .normal)
        btnlater.backgroundColor = AppColor.gray_icon
        btnrate.backgroundColor = AppColor.gray_icon
        btnrate.setTitle(Data.Ratingbtnrate.localized(), for: .normal)
        backview.backgroundColor = .black.withAlphaComponent(0.8)
        viewContent.backgroundColor = UIColor.white
        viewContent.layer.masksToBounds = true
        backview.alpha = 0
        viewContent.alpha = 0
        viewContent.layer.cornerRadius = 5
        // Đặt radius cho góc trên cùng của lbtitle
        viewtop.layer.cornerRadius = 5
        viewtop.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    @IBAction func btnlater(_ sender: Any) {
        hide()
    }

    @IBAction func btnaction(_ sender: Any) {
        if StackRating.starsRating == 0 {
            showToast(message: Data.Ratingtoast.localized())
            return
        }
        if StackRating.starsRating < 5 {
            hide()
            completionHandlermail?()
        } else {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/\(Data.idapp)?action=write-review") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                completionHandler?()
            }
        }
    }

    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.backview.alpha = 1
                self.viewContent.alpha = 1
            }
        }
    }

    func hide() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.viewContent.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
