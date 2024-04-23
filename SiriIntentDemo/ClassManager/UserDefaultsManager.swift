//
//  UserDefaultsManager.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 30/08/2023.
//

import Foundation
class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let suiteName = "group.groupintent"
    
    private init() {} // Khác biệt

    func setCheckValue(_ value: Bool) {
        UserDefaults(suiteName: suiteName)?.set(value, forKey: "checkKey")
        UserDefaults(suiteName: suiteName)?.synchronize()
    }

    func getCheckValue() -> Bool {
        return UserDefaults(suiteName: suiteName)?.bool(forKey: "checkKey") ?? false
    }
    func setnameValue(name: String) {
        UserDefaults(suiteName: suiteName)?.set(name, forKey: "nameApp")
        UserDefaults(suiteName: suiteName)?.synchronize()
    }
    func getnameValue() -> String {
        return UserDefaults(suiteName: suiteName)?.string(forKey: "nameApp") ?? ""
    }
    func setAppValue(nameapp: String, click: Bool) {
        UserDefaults(suiteName: suiteName)?.set(click, forKey: nameapp)
        UserDefaults(suiteName: suiteName)?.synchronize()
    }
    func getAppValue(nameapp: String) -> Bool {
        return UserDefaults(suiteName: suiteName)?.bool(forKey: nameapp) ?? false
    }
}

class UserdefaultQuestionManager {
    static let shared = UserdefaultQuestionManager()
    private init() {} // Khác biệt

    func setQuestionValue(value: String, question: String) {
        UserDefaults.standard.set(value, forKey: question)
        UserDefaults.standard.synchronize()
    }

    func getQuestionValue(question: String) -> String {
        return UserDefaults.standard.string(forKey: question) ?? ""
    }
}
