//
//  Data.swift
//  AppLock
//
//  Created by Tung Anh on 16/09/2023.
//

import Foundation
struct Data {
    // MARK: - Data array

    static var datatb: [(title: String, content: [String])] = [("General", ["Instructions", "Theme", "Change security question", "Change password", "Change language"]), ("Feedback", ["Give us 5 stars", "Send feedback", "Share AppLock", "Privacy Policy"])]

    static var applock: [(name: String, check: Bool)] = [("Facebook", false), ("Messenger", false), ("YouTube", false), ("Zalo", false), ("Messages", false), ("Telegram", false), ("Gmail", false), ("Instagram", false), ("Tiktok", false), ("Twitter", false), ("Notes", false), ("Photos", false), ("Google Drive", false), ("Safari", false), ("ZaloPay", false), ("MoMo", false)]
    static var Structor: [(lb1: String, lb2: String, img: [String])] =
        [("Step 1", "Open the app, select the 'Application' you want to lock and 'open Shortcut' on the iPhone", ["1", "2", ""]), ("Step 2", "Tap the 'Automation' button, then click 'Create personal automation'", ["3", "4", ""]), ("Step 3", "Scroll down and tap 'App'. Tick ​​'Is Opened' and click 'Choose'", ["5", "6", ""]), ("Step 4", "Select the app you want to lock, then click 'Done' and click 'Next', then click 'Add action'", ["7", "8", ""]), ("Step 5", "Select 'Apps' and click 'AppLock' and click 'Lock'", ["9", "10", ""]), ("Step 6", "Click 'Select App' and select the application you want to lock", ["11", "12", ""]), ("Step 7", "Then turn off 'Ask Before Running' and select 'Done'. You have successfully set up!", ["13", "14", ""])]

    // MARK: - ID screen

    static let Idlockscreen = "lockscreenViewController"
    static let IDmain = "Main"
    static let titleTheme = "Theme"
    static let iconquestion = "questionmark.circle"
    static let iconstarempty = "ic_star_empty"
    static let iconstarfill = "ic_star_filled"

    static let iconsetting = "gearshape"

    // MARK: - Color

    static let ColorWhite = "ffffff"
    static let ColorLightBlue = "1CBBFF"
    static let BackgroundPopup = "0f0965"
    static let GradientStart = "08042E"
    static let GradientEnd = "0f0965"

    // MARK: - SearchBar, texttitle

    static let texttitle = "Choose apps to lock"
    static let PlaceholderSearch = "Search"
    static var textonLockscreen = "Click to lock"
    static var textonUnLockscreen = "Click to Unlock"
    static let titlesetting = "Setting"

    // MARK: - POPup

    static let StructorOpenShortcuts = "To perform app locking, you need to use App Shortcuts, click here for instructions"
    static let btnOpenShortcuts = "Open shortcuts"
    static let btncancel = "Cancel"
    static let btnUnlock = "Unlock"
    static let btnwatchvideo = "Watch video tutorial"
    static let StructorUnlock = "Confirm unlocking?"

    static let Questionplaceholder = "Please enter your answer!!!"

    // MARK: - alertChangePass

    static let AlertChangePassTitle = "Password matches"
    static let AlertChangePassMessage = "Password has been changed successfully"

    // MARK: - Alert Switchlanguage

    static let AlertSwitchLanguageTitle = "Switch Language"

    // MARK: - mailComposeVC

    static let Mailsubject = "Your email subject goes here"
    static let Mailbody = "Your email body goes here"
    static let ErrMailtitle = "Error"
    static let ErrMailmessage = "Cannot send email on this device"
    static let ErrMailaction = "Close"

    // MARK: - pWview

    static let PWconfirmNewPassword = "Confirm new password"
    static let PWcurrentPassword = "Current Password"
    static let PWnewPassword = "New Password"
    static let PWrequestPassword = "Request Password"
    static let PWtryAgainIn = "TryAgainIn"
    static let PWbtnDelete = "Delete"
    static let PWpass = "Enter password"

    static let PWcreatenewPassword = "Create New Password"

    // MARK: - Language

    static let LanguageTitle = "Select your language"

    // MARK: - Popup Question

    static let lbQuestionTitle = "SECURITY QUESTION"
    static let textQuestion = "What is your best friend's name?"
    static let lbInstruct = "Security questions are used when you forget your password. You can change questions at any time!"
    static let btnnext = "Next"
    static let btnchange = "Change"
    static let lbLaunchScreen = "Protect your Apps and your privacy"

    // MARK: - Popup Rating

    static let Ratingtitle = "RATE THIS APP"
    static let Ratingbody = "Your feedback are the motivation to help our team develop better products."
    static let Ratingbtnlater = "LATER"
    static let Ratingbtnrate = "RATE"
    static let Ratingtoast = "You have not rated!"

    // MARK: - User

    static let linkapp = "https://www.yourappurl.com"
    static let videoyoutube = "https://www.youtube.com/watch?v=jQyTRCE4aX8"
    static let usermail = "louistunganh@gmail.com"
    static let idapp = "id284882215"
    static let urlappprivacy = "https://falconsecuritylab.github.io/applock/privacy-policy-en.html?fbclid=IwAR3IweWpIcDFmsLOI6x355nR3FkzirkD_5_QN_3IivDCCQuL7DIPqhmDyZo"
    static let IDadsnative = "ca-app-pub-3940256099942544/3986624511"
    static let IDadsInterstitial = "ca-app-pub-3940256099942544/4411468910"
}
