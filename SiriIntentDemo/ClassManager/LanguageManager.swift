

protocol LanguageChangeDelegate: AnyObject {
    func languageDidChange()
}

enum LanguageManager {
    static var currentLanguage: String = "en"
    weak static var delegate: LanguageChangeDelegate?
    static func changeLanguage(to language: String) {
        currentLanguage = language
        delegate?.languageDidChange()
    }
}
