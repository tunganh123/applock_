//
//  Item.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 08/09/2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name: String?
    @objc dynamic var check = false
}
