    //
//  InventorySpriteNode.swift
//  Inventory
//
//  Created by David Norman on 8/15/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation
import SpriteKit

extension Dictionary {
    mutating func map(transform: (key:Key, value:Value) -> (Value)) {
        for key in self.keys {
            var newValue = transform(key: key, value: self[key]!)
            self.updateValue(newValue, forKey: key)
        }
    }
}

protocol InventoryProtocol {
    func updateSlot(item: InventoryItem?)->InventoryItem?
    func selectedNode()->InventoryItemNode?
    var slotSelected: Bool {get set}
}

class InventorySpriteNode: SKSpriteNode, InventoryItemNodeProtocol {
    
    var delegate: InventoryProtocol?
    
    init(size: CGSize) {
        super.init(texture:nil, color: UIColor.clearColor(), size: size)
    }
    
    func showInventory() {
        var tempInvArray = [InventoryItem]()
        for key in GameState.shared.inventoryStorage.keys {
            tempInvArray.append(GameState.shared.inventoryStorage[key]!)
        }
        
        let columns = 9 //change number of columns (rows are auto-calced based on size of view)
        
        let squareWidth = CGFloat(50) //parent!.frame.size.width / CGFloat(columns)
        let rows = 5 //Int(parent!.frame.size.height / squareWidth)
        self.size = CGSizeMake(parent!.frame.size.width, CGFloat(rows) * squareWidth)
        self.anchorPoint = CGPointMake(0.5,0.5)
        self.position = CGPointMake(0, 0)
        self.color = UIColor.greenColor()
        
        for var i = 0; i < columns; i++ {
            for var j = 0; j < rows; j++ {
                var inventoryItem = InventoryItemNode(rectOfSize: CGSize(width: squareWidth, height: squareWidth))
                inventoryItem.delegate = self
                var updatedX = self.frame.origin.x + (CGFloat(inventoryItem.frame.size.width) / CGFloat(2)) + squareWidth * CGFloat(i)
                var updatedY = CGFloat(self.frame.size.height - (CGFloat(inventoryItem.frame.size.height))) / CGFloat(2) - (squareWidth * CGFloat(j))
                inventoryItem.position = CGPoint(x:updatedX, y:updatedY )
                inventoryItem.fillColor = UIColor.blackColor()
                inventoryItem.strokeColor = UIColor.whiteColor()
                inventoryItem.lineWidth = 2.0
                
                
                self.addChild(inventoryItem)
                
                if tempInvArray.count > 0 {
                    let item = tempInvArray.removeLast()
                    inventoryItem.itemName = item.imageName
                    inventoryItem.updateWithItem(item)
                    
                }
            }
        }
    }
    
    class func addNewItemNamed(name: InventoryItemName) {
        if GameState.shared.inventoryStorage[name.rawValue] != nil {
            GameState.shared.inventoryStorage[name.rawValue]?.numberInStack++
        } else {
            GameState.shared.inventoryStorage[name.rawValue] = InventoryItem(name: name, imageName: name.rawValue)
            GameState.shared.inventoryStorage[name.rawValue]?.numberInStack = 1
        }
    }
    
    func InventoryNodeTouched(itemName: String?) {
        let originalItemName = (itemName)

        for (var node) in self.children as [AnyObject] {
            if node.isKindOfClass(InventoryItemNode)
            {
                if (node as! InventoryItemNode).selected {
                    if let itemName = (node as! InventoryItemNode).itemName {
                        println("\(GameState.shared.inventoryStorage[itemName]?.imageName )")
                        var replacedNodeFromSlot = self.delegate?.updateSlot(GameState.shared.inventoryStorage[((node as! InventoryItemNode).itemName)!]!)
                        if replacedNodeFromSlot != nil {
                            (node as! InventoryItemNode).removeAllChildren()
                            (node as! InventoryItemNode).updateWithItem(replacedNodeFromSlot)
                            self.delegate?.updateSlot(GameState.shared.inventoryStorage[originalItemName!])
                        } else {
                            if (self.delegate?.slotSelected == true) {
                                node.removeAllChildren()
                                (node as! InventoryItemNode).updateWithItem(nil)
                            }

                        }

                    } else {
                        //check if slot is selected and move from slot to here
                        if let selectedSlot = self.delegate?.selectedNode() {
                            node.removeAllChildren()
                            if let selectedSlotItemName = selectedSlot.itemName {
                                (node as! InventoryItemNode).updateWithItem(GameState.shared.inventoryStorage[selectedSlot.itemName!])
                                self.delegate?.updateSlot(nil)
                            } else {
                                (node as! InventoryItemNode).updateWithItem(nil)
                                self.delegate?.updateSlot(nil)
                                
                            }

                        }
                    }
                    
                    
                }                
            }
        }
    }
    
    func resetAllNodesToDefault() {
        for node in self.children as [AnyObject] {
            if node.isKindOfClass(InventoryItemNode)
            {
                (node as! InventoryItemNode).deselect()
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
