//
//  SecutityQuestionPopUp.swift
//  AppLock
//
//  Created by Tung Anh on 20/09/2023.
//
import MBSPasswordView
import UIKit
protocol SecutityQuestionDelegate: AnyObject {
    func ButtonTapped()
    func ChangeQuestion()
}
class SecutityQuestionPopUp: UIViewController, UITextFieldDelegate {
    @IBOutlet var backview: UIView!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var lbtitle: UILabel!
    @IBOutlet var lbQuestion: UILabel!
    @IBOutlet var textfield: UITextField!
    @IBOutlet var lbInstruct: UILabel!
    @IBOutlet var btncancel: UIButton!
    @IBOutlet var btnnext: UIButton!
    @IBOutlet var viewtop: UIView!
    var passwordView: MBSPasswordView?
    weak var delegate: SecutityQuestionDelegate?
    var completionHandler: ((String?, String?) -> Void)?
    init() {
        super.init(nibName: "SecutityQuestionPopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        confignotification()
    }

    private func configView() {
        textfield.delegate = self
        view.backgroundColor = .clear
        backview.backgroundColor = .black.withAlphaComponent(0.8)
        viewContent.backgroundColor = UIColor(hex: Data.BackgroundPopup)
        backview.alpha = 0
        viewContent.alpha = 0
        viewContent.layer.cornerRadius = 10
        // Đặt radius cho góc trên cùng của lbtitle
        viewtop.layer.cornerRadius = 10
        viewtop.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        // Đặt khoảng cách từ chữ đến lề trái là 10
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftView = leftPaddingView
        textfield.leftViewMode = .always
        textfield.tintColor = UIColor(hex: Data.GradientEnd)
        lbInstruct.font = UIFont.italicSystemFont(ofSize: 14)
        textfield.backgroundColor = AppColor.white_background
        // Thiết lập nội dung
        lbtitle.text = Data.lbQuestionTitle.localized()
        lbQuestion.text = Data.textQuestion.localized()
        lbInstruct.text = Data.lbInstruct.localized()
        lbInstruct.textColor = AppColor.gray_gray_background
        btncancel.setTitle(Data.btncancel.localized(), for: .normal)
        btnnext.setTitle(Data.btnnext.localized(), for: .normal)
    }
    func confignotification(){
        // Đăng ký sự kiện khi bàn phím xuất hiện
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // Đăng ký sự kiện khi bàn phím biến mất
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        hide()
    }
    @IBAction func btnaction(_ sender: Any) {
        if textfield.text?.count == 0 {
            // Tạo một thuộc tính NSAttributedString với màu đỏ cho placeholder
            let redPlaceholder = NSAttributedString(string: Data.Questionplaceholder.localized(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])

            // Đặt attributedPlaceholder của textfield
            textfield.attributedPlaceholder = redPlaceholder
            textfield.font = UIFont.italicSystemFont(ofSize: 16)
        } else {
            if UserdefaultQuestionManager.shared.getQuestionValue(question: lbQuestion.text!).count != 0 {
                if textfield.text == UserdefaultQuestionManager.shared.getQuestionValue(question: lbQuestion.text!) {
                    hide()
                    delegate?.ButtonTapped()
                } else {
                    completionHandler?(textfield.text, lbQuestion.text)
                    hide()
                    delegate?.ChangeQuestion()
                }
            } else {
                hide()
                UserdefaultQuestionManager.shared.setQuestionValue(value: textfield.text!, question: lbQuestion.text!)
                delegate?.ButtonTapped()
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Tính toán offset để viewContent nằm sát đáy dưới cùng của bàn phím
            let viewContentMaxY = viewContent.frame.maxY
            let keyboardMinY = keyboardSize.minY
            let offset = viewContentMaxY - keyboardMinY

            // Kiểm tra nếu offset âm (khi bàn phím che khuất viewContent), thì không thay đổi transform
            if offset > 0 {
                viewContent.transform = CGAffineTransform(translationX: 0, y: -offset)
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Đặt lại viewContent về vị trí ban đầu
        viewContent.transform = CGAffineTransform.identity
    }
}
