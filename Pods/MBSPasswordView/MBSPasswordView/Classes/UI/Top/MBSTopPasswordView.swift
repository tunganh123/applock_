//
//  MBSTopPasswordView.swift
//  MBSPasswordView
//
//  Created by Mayckon Barbosa da Silva on 11/3/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//
import AVFoundation
import UIKit

// Enums and Protocol
public enum PasswordAnimation {
    case bottomToTop
    // case growUp
}

public enum InvalidPasswordResult {
    case biometrics
    case loginPassword(_ wrongPassword: [String])
    case registerPassword(_ wrongPassword: [String])
}

public protocol MBSTopPasswordViewType {
    /// kind of animation
    var passwordAnimation: PasswordAnimation { get set }
    /// color of password views
    var dotColor: UIColor { get set }
    /// background which appears when passwords don't match
    var errorBackgroundColor: UIColor { get set }
    /// color of uilabel
    var labelColor: UIColor { get set }
    /// font of label alert
    var font: UIFont? { get set }
    
    /// labels
    var currentPassword: String { get set } // "Inform the current password"
    var requestPassword: String { get set } // "Inform your password"
    var newPassword: String { get set } // "Enter new password"
    var confirmNewPassword: String { get set } // "Confirm new password"
    var tryAgainIn: String { get set }
}

public protocol MBSTopPasswordDelegate: class {
    func invalidMatch(_ result: InvalidPasswordResult)
    func password(_ result: [String])
    func resetbg()
}

// Implementation
public class MBSTopPasswordView: UIView, MBSTopPasswordViewType {
    public var currentPassword = "Inform the current password"
    public var requestPassword = "Inform your password"
    public var newPassword: String = "Enter new password" {
        didSet { lblPasswordRequest?.text = newPassword }
    }

    public var confirmNewPassword = "Confirm new password"
    public var tryAgainIn: String = "Try again in"
    enum ViewState {
        case login
        case confirmation
        case validatePassword
        case newPassword
        case passwordInvalid
        case passwordMatch
        case changePasswordRequest
        case changePasswordNewPassword
    }
    
    @IBOutlet var lblPasswordRequest: UILabel!
    
    // protocol variables
    public var passwordAnimation: PasswordAnimation = .bottomToTop
    public var dotColor: UIColor = .white
    public var errorBackgroundColor: UIColor = .flatRed
    public var labelColor: UIColor = .white {
        didSet { lblPasswordRequest.textColor = labelColor }
    }

    public var font: UIFont? = UIFont(name: "Helvetica", size: 32) {
        didSet { lblPasswordRequest.font = font }
    }
    
    // internal
    public var passwordValues: [String] = []
    internal var confirmationValues: [String] = []
    public var passwordViews: [UIView] = []
    internal var passwordRegistered: [String]? {
        didSet {
            if let password = passwordRegistered {
                passwordValues.append(contentsOf: password)
                changeStateTo(newState: .login)
            }
        }
    }

    internal var changeExistingPassword = false {
        didSet {
            if changeExistingPassword, let password = passwordRegistered {
                isConfirmationMode = true
                passwordValues = password
                changeStateTo(newState: .changePasswordRequest)
            }
        }
    }

    internal var isConfirmationMode = false
    
    // private
    private let passwordLenght: Int = 4
    private var viewState: ViewState = .newPassword
    private var isLogin: Bool {
        return passwordRegistered != nil
    }
    
    // delegate
    public var delegate: MBSTopPasswordDelegate!
    
    // Property size variables
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.flatDarkBlue
    }
    
    private func changeStateTo(newState: ViewState) {
        viewState = newState
        switch newState {
        case .newPassword:
            removeAllPasswordViews()
            removePasswordArrayData()
            passwordMode()
            
        case .confirmation:
            switchMode {
                self.removeAllPasswordViews()
            }
            
        case .login:
            registeredPassswordMode()
            
        case .changePasswordRequest:
            changePasswordMode()
            
        case .changePasswordNewPassword:
            isConfirmationMode = false
            changeExistingPassword = false
            passwordRegistered = nil
            
            removeAllPasswordViews()
            removePasswordArrayData()
            passwordMode()
            
        case .validatePassword:
            handleConfirmation()
            
        case .passwordInvalid:
            let tmpConfirmationValues = confirmationValues
            if isLogin {
                let newState = changeExistingPassword ? ViewState.changePasswordRequest : ViewState.login
                changeToNewStateWithDelay(newState: newState) {
                    self.invalidPassword(.loginPassword(tmpConfirmationValues))
                }
            } else {
                changeToNewStateWithDelay(newState: .newPassword) {
                    self.invalidPassword(.registerPassword(tmpConfirmationValues))
                }
            }
            
        case .passwordMatch:
            delegate?.password(passwordValues)
        }
    }
    
    private func invalidPassword(_ result: InvalidPasswordResult) {
        removeAllPasswordViews()
        removePasswordArrayData()
        notifyPasswordInvalid(result)
    }
    
    private func changeToNewStateWithDelay(newState: ViewState, completion: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.changeStateTo(newState: newState)
            completion?()
        }
    }
    
    // MARK: Flow methods

    internal func insert(_ value: String) {
        // limited to 4
        if passwordViews.count == passwordLenght { return }
        // normal flow
        if isConfirmationMode {
            confirmationValues.append(value)
            addDotView()
            
            if confirmationValues.count == passwordLenght {
                changeStateTo(newState: .validatePassword)
            }
        } else {
            passwordValues.append(value)
            addDotView()
            if passwordValues.count == passwordLenght {
                changeStateTo(newState: .confirmation)
            }
        }
    }
    
    internal func removeLast() {
        guard let viewPassword = passwordViews.last else { return }
        passwordViews.removeLast()
        hideAnimatedPassword(viewPassword)
        
        if isConfirmationMode || isLogin {
            confirmationValues.removeLast()
        } else {
            passwordValues.removeLast()
        }
    }
}

// MARK: Auxiliar flow methods

extension MBSTopPasswordView {
    private func insertPasswordView() -> UIView {
//        var xPosition = frame.size.width - (frame.size.width * 0.8)
//
//        if let last = passwordViews.last {
//            xPosition = last.frame.origin.x + (frame.size.width * 0.17)
//        }
//
//        // add the view
//        let viewPassword = UIView()
//        viewPassword.backgroundColor = .clear
//        getSuperview().addSubview(viewPassword)
//        viewPassword.frame = CGRect(x: xPosition, y: frame.size.height + 10, width: 30, height: 30)
//        viewPassword.layer.cornerRadius = viewPassword.frame.size.width/2
//        viewPassword.clipsToBounds = true
//        viewPassword.alpha = 0.0
//
//        return viewPassword
        let spacing: CGFloat = 15 // Khoảng cách giữa các viewPassword
        let totalWidth = CGFloat(passwordLenght) * 15 + CGFloat(passwordLenght - 1) * spacing
        let startX = (frame.size.width - totalWidth)/2.0 // Bắt đầu từ trung tâm
        var xPosition = startX
        if let last = passwordViews.last {
            xPosition = last.frame.origin.x + last.frame.size.width + spacing
        } else {
            xPosition = startX
        }
            
        // add the view
        let viewPassword = UIView()
        viewPassword.backgroundColor = .clear
        getSuperview().addSubview(viewPassword)
        viewPassword.frame = CGRect(x: xPosition, y: frame.size.height + 10, width: 15, height: 15)
        viewPassword.layer.cornerRadius = viewPassword.frame.size.width/2
        viewPassword.clipsToBounds = true
        viewPassword.alpha = 0.0
            
        return viewPassword
    }

    private func removeAllPasswordViews() {
        for viewPassword in passwordViews {
            viewPassword.removeFromSuperview()
        }
        passwordViews = []
    }

    private func removePasswordArrayData() {
        removeAllPasswordViews()
        if passwordRegistered == nil {
            passwordValues.removeAll()
        }
        confirmationValues.removeAll()
    }
    
    private func handleConfirmation() {
        if passwordValues == confirmationValues {
            if changeExistingPassword {
                changeToNewStateWithDelay(newState: .changePasswordNewPassword, completion: nil)
            } else {
                changeStateTo(newState: .passwordMatch)
            }
        } else {
            changeStateTo(newState: .passwordInvalid)
        }
    }
    
    private func addDotView() {
        let passwordView = insertPasswordView()
        passwordViews.append(passwordView)
        showAnimatedPassword(passwordView)
    }
    
    private func notifyPasswordInvalid(_ result: InvalidPasswordResult) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        showErrorAnimation(
            completion: {
                self.delegate?.invalidMatch(result)
            },
            resetbg: {
                self.delegate?.resetbg()
            }
        )
    }
}

// MARK: Animations

extension MBSTopPasswordView {
    private func showAnimatedPassword(_ viewPassword: UIView) {
        UIView.animate(withDuration: 0.2,
                       animations: {
                           let xPosition = viewPassword.frame.origin.x + (viewPassword.frame.size.width/2)
                           let yPosition = self.lblPasswordRequest.frame.origin.y + (self.frame.size.height * 0.2)
                           viewPassword.center = CGPoint(x: xPosition, y: yPosition)
                           viewPassword.backgroundColor = self.dotColor
                           viewPassword.alpha = 1
                       })
    }

    private func hideAnimatedPassword(_ viewPassword: UIView) {
        UIView.animate(withDuration: 0.2,
                       animations: {
                           let xPosition = viewPassword.frame.origin.x + (viewPassword.frame.size.width/2)
                           let yPosition = self.frame.size.height + viewPassword.frame.size.height
                           viewPassword.center = CGPoint(x: xPosition, y: yPosition)
                           viewPassword.backgroundColor = .white
                           viewPassword.alpha = 0.0
                       })
    }
    
    private func switchMode(with completion: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.viewState == .changePasswordRequest {
                self.passwordMode()
            } else {
                self.isConfirmationMode ? self.passwordMode() : self.confirmationMode()
            }
            completion()
        }
    }
    
    func showErrorAnimation(completion: @escaping () -> Void, resetbg: @escaping () -> Void) {
        let currentBackgroundColor = backgroundColor
//        backgroundColor = errorBackgroundColor
        completion()
        UIView.animate(withDuration: 2.0,
                       animations: {
                           self.backgroundColor = UIColor.clear
                           resetbg()
                       })
    }
}

// MARK: Get views

extension MBSTopPasswordView {
    private func getSuperview() -> UIView {
        guard let superview = superview else { fatalError("There is no superview. Please, add a superview to this view.") }
        return superview
    }
    
    private func getLastPasswordView() -> UIView {
        guard let passwordView = passwordViews.last else { fatalError("Crash on apple API. Attribute: isEmpty is false, but there's no element on array") }
        return passwordView
    }
}

// MARK: - Screen modes

extension MBSTopPasswordView {
    private func confirmationMode() {
        isConfirmationMode = true
        lblPasswordRequest.text = confirmNewPassword
    }

    private func passwordMode() {
        isConfirmationMode = false
        lblPasswordRequest.text = newPassword
    }

    private func registeredPassswordMode() {
        isConfirmationMode = true
        lblPasswordRequest.text = requestPassword
    }

    func updateLabel() {
        if changeExistingPassword {
            changePasswordMode()
        } else {
            registeredPassswordMode()
        }
    }

    private func changePasswordMode() {
        isConfirmationMode = true
        lblPasswordRequest.text = currentPassword
    }
}
