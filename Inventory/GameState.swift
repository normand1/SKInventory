//
//  GameState.swift
//  Inventory
//
//  Created by David Norman on 8/15/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation

class GameState {
    
    static let shared = GameState()
    
    var inventoryStorage = [String : InventoryItem]()
    
}