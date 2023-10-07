//
//  RealmManager.swift
//  AppLock
//
//  Created by Tung Anh on 04/10/2023.
//

import Foundation
import RealmSwift
class RealmManager {
    static let shared = RealmManager()
    let realm: Realm

    private init() {
        // Khởi tạo Realm trong constructor private để ngăn chặn việc tạo thêm đối tượng RealmManager
        realm = try! Realm()
    }

    func getThemeItem() -> Results<ThemeItem> {
        return realm.objects(ThemeItem.self)
    }

    func addThemeItem(_ object: ThemeItem) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error adding object to Realm: \(error)")
        }
    }

    // Cập nhật đối tượng trong Realm
    func updateThemeItem(_ object: ThemeItem, value: String) {
        do {
            try realm.write {
                object.themename = value
            }
        } catch {
            print("Error updating object in Realm: \(error)")
        }
    }

    // Xoá đối tượng khỏi Realm
    func deleteThemeItem(_ object: ThemeItem) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object from Realm: \(error)")
        }
    }
    
    func getAppItem() -> Results<Item> {
        return realm.objects(Item.self)
    }

    // Cập nhật đối tượng trong Realm
    func updateAppItem(_ object: Item, value: Bool) {
        do {
            try realm.write {
                object.check = value
            }
        } catch {
            print("Error updating object in Realm: \(error)")
        }
    }
    func addAppItem(_ object: Item) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error adding object to Realm: \(error)")
        }
    }

}
