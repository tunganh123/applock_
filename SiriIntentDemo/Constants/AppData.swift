
import Foundation
struct DataConstants {
    static let GradientStart = "08042E"
    static let GradientEnd = "0f0965"

    // MARK: - Data array

    static var dataServer: [String] = ["vietnam", "australia", "canada", "china", "france", "germany", "hongkong", "india", "indonesia", "japan", "korea", "mexico", "russia", "singapore", "spain", "sweden", "switzerland", "taiwan", "thailand", "united kingdom"]
    static var dataHome: [String] = ["", "Cast Media", "Cast Youtube", "Ads"]

    // MARK: - Popup Rating

    static let Ratingtitle = "RATE THIS APP"
    static let Ratingbody = "Your feedback are the motivation to help our team develop better products."
    static let Ratingbtnlater = "LATER"
    static let Ratingbtnrate = "RATE"
    static let Ratingtoast = "You have not rated!"
    static let iconstarempty = "ic_star_empty"
    static let iconstarfill = "ic_star_filled"

    // MARK: - mailComposeVC

    static let usermail = "louistunganh@gmail.com"
    static let Mailsubject = "Your email subject goes here"
    static let Mailbody = "Your email body goes here"
    static let ErrMailtitle = "Error"
    static let ErrMailmessage = "Cannot send email on this device"
    static let ErrMailaction = "Close"

    // MARK: - User

    static let linkapp = "https://www.yourappurl.com"
    static let urlappprivacy = "https://falconsecuritylab.github.io/applock/privacy-policy-en.html?fbclid=IwAR3IweWpIcDFmsLOI6x355nR3FkzirkD_5_QN_3IivDCCQuL7DIPqhmDyZo"
    static let idapp = "id6478912899"
    static let IDadsnative = "ca-app-pub-3940256099942544/3986624511"
    static let IDadsInterstitial = "ca-app-pub-3940256099942544/4411468910"
    static var App_name = "Speed Test"
    static let urlgetIP = "https://www.speedtest.net/speedtest-config.php?fbclid=IwAR3roPzmKNq8eGHs9k-I71omIBxSI9p504FgqQED"
    // text localize
    static let textCastpt = "Cast Image"
    static let textCastvd = "Cast Video"
    static let textCastyt = "Cast Youtube"
    static let textCastad = "Cast Audio"
    static let textPlay = "play"
    static let textPause = "pause"
    static let textDOWNLOAD = "DOWN LOAD"
    static let textUPLOAD = "UP LOAD"
    // LaunchScreen
    static var LaunchScreen_tit = "Speed Test"
    static var LaunchScreen_des = "Test your Internet speed"
    // Title
    static let titleHome = "Speed Test"
    ///////////////////////
    // Top view Sidemenu
    static let lbSidemenu_unit = "Unit"
    static let lbSidemenu = "Speed Test"
    static var dataSideMenu: [(content: String, image: String)] = [("Change Language", "ic_changeLanguage"), ("Rating app", "star"), ("Share app", "arrowshape.turn.up.right"), ("Feedback", "message"), ("Privacy Policy", "person.badge.key"), ("More of our apps", "plus.circle")]
    // View Home
    static var Viewhome_title_changeServer = "Sellect Server"
    static var Viewhome_lbStart = "Start"
    // ViewTools
    static var Viewtool_infor_lbtop = "Info your wifi details"
    static var Viewtool_infor_lbbot = "(It provides detailed information about the wifi you are connecting to)"
    static var Viewtool_devices_lbtop = "Who connected to your wifi?"
    static var Viewtool_devices_lbbot = "(Scan for devices connected to your router)"

    // viewdevice_connected
    static var viewdevice_your = "( Your device )"
    static var viewdevice_title = "Connecting devices"
    static let viewdevice_navititle = "Who connected your Wifi?"
    static let viewdevice_deviceOnline = "Devices online"
    // ViewInfo
    static var dataViewinfo = ["Wifi name", "Status", "IP public", "IP LAN", "Service provider", "Country", "Longitude", "Latitude"]
    static let viewinfo_navititle = "Wifi details"
    static let viewinfo_connected = "Connected"
    static let viewinfo_notconnected = "Not connect"
    static let viewinfo_cannotget = "Cannot get"
    // ViewHistory:
    static var dataHeaderHistory: [(title: String, image: String)] = [("Type", "ic_type"), ("Date", "ic_date"), ("Download", "ic_download_white"), ("Upload", "ic_upload_white"), ("State", "ic_state")]
    static var viewHistory_lbEmpty = "You don't have any test results yet"
    static var viewHistory_btnEmpty = "Start Speed testing"
    static var viewHistory_alertTitle = "Are you sure you want to delete?"
    static var viewHistory_alertCancel = "Cancel"
    static var viewHistory_alertOk = "OK"
    // ViewChangeServer
    static let ViewChangeServer_navititle = "Change Server"
    static let ViewChangeServer_placehoder = "Search by country name ..."
    // View Check permition
    /////LOCATIOn
    static let ViewCheckpermission_checkLocationTitle = "Location"
    static let ViewCheckpermission_checkLocationtop = "Allow Speedtest to gather your location to find the nearest testing server, and improve your maps experience?"
    static let ViewCheckpermission_checkLocationbot = "Finding your closest testing server will give you the most accurate result."
    /////ADS
    static let ViewCheckpermission_checkAdsTitle = "Ad Setting"
    static let ViewCheckpermission_checkAdstop = "Allow interest-based ads and data collection for targeted advertising purposes?"
    static let ViewCheckpermission_checkAdsbot = "By enabling this option, you consent to the collection of information about your preferences, online activities, and interactions with ads. This data will be used to tailor advertisements specifically to your interests and deliver a more personalized advertising experience."
    ////NETWORK
    static let ViewCheckpermission_checkNetworkTitle = "Network"
    static let ViewCheckpermission_checkNetworktop = "Allow Speedtest to find and connect to devices on your local network?"
    static let ViewCheckpermission_checkNetworkbot = "This app will be able to detect and connect to devices on the networks you use."
    // ViewResult network signal
    static let ViewResult_navititle = "Result"
    static let ViewResult_titleSignal = "Network signal"
    static let ViewResult_SignalStrong = "Strong"
    static let ViewResult_SignalMedium = "Medium"
    static let ViewResult_SignalWeak = "Weak"
    // ViewResult network infor
    static let ViewResult_networkInforArr = ["Name wifi", "Bandwidth", "ISP", "IP LAN", "IP Public"]
    static let ViewResult_networkInfor = "Network"
    static let ViewResult_ServerInfor = "Server"
    static let ViewResult_ServerInforArr = ["Name server", "Server location", "Service provider", "Nation", "Distance"]
    // ViewResult network Try another Server
    static let ViewResult_titleTry = "Try with other servers"
    // View Change Language
    static let ViewchangeLanguage_title = "Change Language"
    // Cell
    static var Cell_reuseMenu = "Cellreuse"
    static var Cell_Home = "CellHome"
    static var Cell_Ads = "NativeCell"
    static var Cell_HomeMirror = "CellHomeMirror"
    static var Cell_device = "Celldevice"
    // IC
    static var Ic_Delete = "ic_delete"
    static var Ic_Menu = "ic_menu"
    static var Ic_instruct = "ic_instruct"
    static var Ic_Chromecast = "chromecast"
    static var Ic_download = "ic_download"
    static var Ic_upload = "ic_upload"
    // Unit
    static var Unit_0 = "Mbps"
    static var Unit_1 = "MB/s"
    // POPUP warning
    static var popup_warning_instruct = "You need connect wifi or cellular first !"
    static var popup_warning_low = "Your network is very weak. Please check your connection again or switch network"
    // Tabbar
    static var Tabbar = ["Home","More","History"]
    // State wifi
    static var State_weak = "Weak"
    static var State_strong = "Strong"
    static var State_medium = "Medium"
    static var NotConnected = "Not Connected"
    //Cell_connected wifi
    static var Cell_connected_btn = "Start"
    //Cell_Try_server
    static var Cell_Try_server_btn = "Check"
    // View Check permition
    static var View_Check_permition_btn = "Understood"
}
