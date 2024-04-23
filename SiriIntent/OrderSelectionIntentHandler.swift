import Foundation
import Intents
import UIKit
let a: [(name: String, check: Bool)] = [("Facebook", false), ("Messenger", false), ("YouTube", false), ("Zalo", false), ("Messages", false), ("Telegram", false), ("Gmail", false), ("Instagram", false), ("Tiktok", false), ("Twitter", false), ("Notes", false), ("Photos", false), ("Google Drive", false), ("Safari", false), ("ZaloPay", false), ("MoMo", false)]
class OrderSelectionIntentHandler: NSObject, OrderSelectionIntentHandling {
    var orderTypes: [NSString] = []

    func provideOrderTypeOptionsCollection(for intent: OrderSelectionIntent, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        for item in a {
            if let defaults = UserDefaults(suiteName: "group.groupintent") {
                let savedCheck = defaults.value(forKey: item.name) as? Bool
                if savedCheck == true {
                    orderTypes.append(item.name as NSString)
                }
            }
        }
        // Tạo một mảng chứa các loại đơn hàng kiểu NSString
        // Tạo một mảng chứa các đối tượng INObject từ danh sách loại đơn hvàng
        let objectArray = orderTypes.map { orderType in
            INObject(identifier: orderType as String, display: orderType as String)
        }

        let collection = INObjectCollection(items: objectArray)
        let stringArray: [NSString] = collection.allItems.map { inObject in
            inObject.displayString as NSString
        }
        let newCollection = INObjectCollection<NSString>(items: stringArray)
        completion(newCollection, nil)
    }

//    func defaultOrderType(for intent: OrderSelectionIntent) -> String? {
//        return "tiktok"
//    }

    func resolveOrderType(for intent: OrderSelectionIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        completion(INStringResolutionResult.success(with: intent.orderType!))
    }

    func confirm(intent: OrderSelectionIntent, completion: @escaping (OrderSelectionIntentResponse) -> Void) {
        let activity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
        activity.userInfo = ["name": intent.orderType!]
        completion(OrderSelectionIntentResponse(code: .success, userActivity: activity))
    }

    func handle(intent: OrderSelectionIntent, completion: @escaping (OrderSelectionIntentResponse) -> Void) {
        if let defaults = UserDefaults(suiteName: "group.groupintent") {
            let savedCheck = defaults.value(forKey: "checkKey") as? Bool ?? false
            var orderlist: [String] = []
            for item in a {
                let savedCheck = defaults.value(forKey: item.name) as? Bool
                if savedCheck == true {
                    orderTypes.append(item.name as NSString)
                    orderlist.append(item.name)
                }
            }

            if savedCheck == false {
                // chuyển tap nhập mk
                if orderlist.contains(intent.orderType!) {
                    completion(OrderSelectionIntentResponse(code: .continueInApp, userActivity: nil))
                } else {
                    // Xử lý tương ứng ở đây
                    defaults.set(false, forKey: "checkKey")
                    defaults.synchronize()
                    completion(OrderSelectionIntentResponse(code: .success, userActivity: nil))
                }
            } else {
                defaults.set(false, forKey: "checkKey")
                defaults.synchronize()
                completion(OrderSelectionIntentResponse(code: .success, userActivity: nil))
            }
        }
    }
}
