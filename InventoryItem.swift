//
//  InventoryItem.swift
//  Inventory
//
//  Created by David Norman on 8/15/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation

enum InventoryItemName: String {
    case sword_diamond = "sword_diamond"
    case flail_bronze = "flail_bronze"
    case hammer_gold = "hammer_gold"
    case ore_emerald = "ore_emerald"
    case ore_ruby = "ore_ruby"
    case pick_silver = "pick_silver"
    case stew = "stew"
    case sword_gold = "sword_gold"
    case sword_silver = "sword_silver"
    case wheat = "wheat"
    
}

class InventoryItem {

    var name: InventoryItemName?
    var imageName: String?
    var numberInStack = 0
    
    init(name: InventoryItemName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}