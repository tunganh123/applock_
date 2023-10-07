//
//  MBSPasswordViewController.swift
//  MBSPasswordView
//
//  Created by Mayckon Barbosa da Silva on 11/3/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import LocalAuthentication
import UIKit

public enum KindBiometrics: String {
    case touchID = "Touch ID"
    case faceID = "Face ID"
    case none = ""
}

public protocol MBSPasswordViewType {
    static var isBiometricsActivate: Bool { get set }
    static func deviceBiometricsKind() -> KindBiometrics
    
    var isShakable: Bool { get set }
    var titleToRequestAuthentication: String { get set }
    func changeExistingPassword()
    func start(enableBiometrics: Bool)
}

public protocol MBSPasswordDelegate: class {
    func wrongPassword(_ result: InvalidPasswordResult)
    func password(_ result: [String])
    func passwordFromBiometrics(_ result: MBSPasswordResult<[String]>)
}

public class MBSPasswordView: UIView, MBSPasswordViewType {
    @IBOutlet public var imgtop: UIImageView!
    @IBOutlet public var topView: MBSTopPasswordView!
    @IBOutlet public var ViewContent: UIView!
    @IBOutlet public var img1: UIImageView!
    @IBOutlet public var bodyView: MBSBodyPasswordView!
    @IBOutlet public var btndelete: MBSButton!
    @IBOutlet public var IMG: UIImageView!
    public weak var delegate: MBSPasswordDelegate!
    public var isAttemptsLimitReached = false

    // MARK: - MBSPasswordViewType protocol vars

    public var isShakable: Bool = true
    public var titleToRequestAuthentication: String = "Identify yourself!"
    public static var isBiometricsActivate: Bool {
        get {
            let userDefaults = UserDefaults()
            if let value = userDefaults.value(forKey: MBSPasswordSetValues.isBiometricsActivate.rawValue) as? Bool {
                return value
            }
            return false
        }
        set {
            let userDefaults = UserDefaults()
            userDefaults.set(newValue, forKey: MBSPasswordSetValues.isBiometricsActivate.rawValue)
        }
    }
    
    internal var view: UIView!
    internal var enableBiometricsAuthentication: Bool = false
    
    private var count = 15
    private var timer: Timer!
    private var isTimerRunning = false
    private var topViewTitle = ""
    private var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        commonInit()
    }
    
    public func loadNib() {
        // load and instantantiate xib
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        // set frame and constraints to superview's size.
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // add on view
        addSubview(view)
        self.view = view
    }
    
    public func commonInit() {
        topView.delegate = self
        topView.passwordRegistered = passwordRegistered()
        bodyView.delegate = self
//        disableViews()
    }
    
    public func disableViews() {
        topView.isUserInteractionEnabled = false
        bodyView.isUserInteractionEnabled = false
    }
    
    public func enableViews() {
        topView.isUserInteractionEnabled = true
        bodyView.isUserInteractionEnabled = true
    }
    
    // MARK: - MBSPasswordViewType protocol methods

    public func start(enableBiometrics: Bool) {
        checkIfRunningDisableState()
        enableBiometricsAuthentication = enableBiometrics
        if let password = passwordRegistered() {
            callBiometricsIfEnabled(password)
        }
    }
    
    public func changeExistingPassword() {
        topView.changeExistingPassword = true
    }
    
    public static func deviceBiometricsKind() -> KindBiometrics {
        let kind = LAContext().biometricType
        switch kind {
        case .faceID:
            return KindBiometrics.faceID
        case .touchID:
            return KindBiometrics.touchID
        case .none:
            return KindBiometrics.none
        }
    }
}

// MARK: - Protocols to support MBSTopPasswordView

extension MBSPasswordView: MBSTopPasswordDelegate, Shakable {
    public func resetbg() {
    }
    
    public func invalidMatch(_ result: InvalidPasswordResult) {
        delegate?.wrongPassword(result)
        shakeView()
        disableStateIfNeeded()
    }
    
    public func password(_ result: [String]) {
        registerPassword(result)
        disableViews()
        authenticateUser(result)
    }
    
    private func shakeView() {
        if isShakable {
            shake()
        }
    }
}

// MARK: - Disable and Enable View State

extension MBSPasswordView {
    // limit is 2
    public func isLimitAttemptsOut() -> Bool {
        let userDefaults = UserDefaults()
        if let quantity = userDefaults.object(forKey: MBSAttempts.quantity.rawValue) as? Int {
            let newQuantity = quantity - 1
            userDefaults.set(newQuantity, forKey: MBSAttempts.quantity.rawValue)
            userDefaults.synchronize()
            return newQuantity == 0
        } else {
            userDefaults.set(2, forKey: MBSAttempts.quantity.rawValue)
            userDefaults.synchronize()
            return false
        }
    }
    
    private func disableStateIfNeeded() {
        if isLimitAttemptsOut() {
            isAttemptsLimitReached = true
            // Hiển thị thông báo
//            registerMinutesCount()
//            disableState()
        }
    }
    
    public func disableState() {
        alpha = 0.8
        disableViews()
        runTimer()
    }
    
    private func registerMinutesCount(_ minutes: Int = 2) {
        let userDefaults = UserDefaults()
        userDefaults.set(minutes, forKey: MBSAttempts.minutes.rawValue)
        userDefaults.synchronize()
    }
    
    private func cleanMinutesCount() {
        let userDefaults = UserDefaults()
        userDefaults.removeObject(forKey: MBSAttempts.minutes.rawValue)
        userDefaults.synchronize()
    }
    
    private func checkIfRunningDisableState() {
        let userDefaults = UserDefaults()
        if let minutes = userDefaults.object(forKey: MBSAttempts.minutes.rawValue) as? Int {
            if minutes > 0 {
                disableState()
            }
        } else {
            enableViews()
            // start with the standard value of attempts
            registerQuantityCount()
        }
    }
    
    private func registerQuantityCount() {
        let userDefaults = UserDefaults()
        userDefaults.set(2, forKey: MBSAttempts.quantity.rawValue)
        userDefaults.synchronize()
    }
    
    private func runTimer() {
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)
        })
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        count -= 1
        // update label top view
        runCountDown()
    }
    
    private func resetCount() {
        count = 15
    }
    
    private func enableState() {
        enableViews()
        alpha = 1.0
    }
    
    private func runCountDown() {
        if count > 0 {
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            let secondsFormatted = Int(seconds)! < 10 ? "0\(seconds)" : seconds
            let tryAgainIn = topView.tryAgainIn
            topView.lblPasswordRequest.text = "\(tryAgainIn) 0\(minutes + ":" + secondsFormatted)"
        } else {
            topView.updateLabel()
            registerQuantityCount()
            cleanMinutesCount()
            enableState()
            stopTimer()
            resetCount()
        }
    }
    
    private func stopTimer() {
        timer.invalidate()
        timer = nil
    }
}

// MARK: - Protocols to support MBSBodyPasswordView

extension MBSPasswordView: MBSBodyPasswordDelegate {
    public func selected(_ value: String) {
        topView.insert(value)
    }

    public func removeLast() {
        topView.removeLast()
    }
}

// MARK: - Flag the authentication

public extension MBSPasswordView {
    private func registerPassword(_ password: [String]) {
        let userDefaults = UserDefaults()
        userDefaults.set(password, forKey: MBSUserAuthetication.done.rawValue)
    }
    
    func passwordRegistered() -> [String]? {
        let userDefaults = UserDefaults()
        return userDefaults.value(forKey: MBSUserAuthetication.done.rawValue) as? [String]
    }
    
    static func cleanPasswordUserDefaults() {
        let userDefaults = UserDefaults()
        if let _ = userDefaults.value(forKey: MBSUserAuthetication.done.rawValue) as? [String] {
            userDefaults.removeObject(forKey: MBSUserAuthetication.done.rawValue)
            userDefaults.synchronize()
        }
    }
}

// MARK: - Request Authentication

extension MBSPasswordView: MBSAuthenticatable {
    private func callBiometricsIfEnabled(_ password: [String]) {
        if enableBiometricsAuthentication {
            authenticateByBiometrics(title: titleToRequestAuthentication) { result in
                switch result {
                case .success:
                    self.delegate?.passwordFromBiometrics(MBSPasswordResult.success(password))
                case .error(let error):
                    self.emitWrongBiometricsIfNeeded(error)
                    // we won't request on the next try... User should try by password
                    self.enableBiometricsAuthentication = false
                    self.delegate?.passwordFromBiometrics(MBSPasswordResult.error(error))
                }
            }
        }
    }
    
    private func authenticateUser(_ password: [String]) {
        if enableBiometricsAuthentication {
            authenticateByBiometrics(title: titleToRequestAuthentication) { result in
                switch result {
                case .success:
                    self.delegate?.passwordFromBiometrics(MBSPasswordResult.success(password))
                case .error(let error):
                    self.emitWrongBiometricsIfNeeded(error)
                    // we won't request on the next try... User should try by password
                    self.enableBiometricsAuthentication = false
                    self.delegate?.passwordFromBiometrics(MBSPasswordResult.error(error))
                }
            }
        } else {
            delegate?.password(password)
        }
    }
    
    private func emitWrongBiometricsIfNeeded(_ error: Error?) {
        if let error = error as? LAError {
            switch error.code {
            case .authenticationFailed, .biometryLockout:
                delegate?.wrongPassword(.biometrics)
            default: break
            }
        }
    }
}
