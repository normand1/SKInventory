//
//  SlotsSpriteNode.swift
//  Inventory
//
//  Created by David Norman on 8/16/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import SpriteKit
import Foundation



class SlotsSpriteNode: SKSpriteNode,InventoryItemNodeProtocol, InventoryProtocol {
    
    var slotSelected: Bool
    
    init(size: CGSize) {
        slotSelected = false
        super.init(texture:nil, color: UIColor.clearColor(), size: size)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showInventory() {

        let numberOfSlots = 5
        
        let columns = 1 //change number of columns (rows are auto-calced based on size of view)
        
        let squareWidth = CGFloat(50) //parent!.frame.size.width / CGFloat(columns)
        let rows = 5 //Int(parent!.frame.size.height / squareWidth)

        self.size = CGSizeMake(squareWidth, CGFloat(rows) * squareWidth)
        self.anchorPoint = CGPointMake(0.0,0.5)
        self.position = CGPointMake(self.parent!.frame.width / 2 - squareWidth, 0)
        self.color = UIColor.yellowColor()
        
        for var i = 0; i < rows; i++ {
                
                var inventoryItem = InventoryItemNode(rectOfSize: CGSize(width: squareWidth, height: squareWidth))
                inventoryItem.delegate = self
                var updatedX = CGFloat(squareWidth / 2) //+ (CGFloat(squareWidth) / CGFloat(2)) //+ (CGFloat(inventoryItem.frame.size.width) / CGFloat(2)) + squareWidth * CGFloat(i)
                var updatedY = CGFloat(self.frame.size.height - (CGFloat(inventoryItem.frame.size.height))) / CGFloat(2) - (squareWidth * CGFloat(i))
                
                inventoryItem.position = CGPoint(x:updatedX, y:updatedY )
                inventoryItem.fillColor = UIColor.blackColor()
                inventoryItem.strokeColor = UIColor.whiteColor()
                inventoryItem.lineWidth = 2.0
                
                
                self.addChild(inventoryItem)
            
        }
    }
    
    func selectedNode()->InventoryItemNode? {
        for node in self.children as [AnyObject] {
            if node.isKindOfClass(InventoryItemNode)
            {
                if (node as! InventoryItemNode).selected {
                    slotSelected = true
                    return node as? InventoryItemNode
                }
            }
        }
        
        return nil
    }
    
    func InventoryNodeTouched(itemName: String?)
    {
        for node in self.children as [AnyObject] {
            if node.isKindOfClass(InventoryItemNode)
            {
//                (node as! InventoryItemNode).deselect()
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
    
    func updateSlot(item: InventoryItem?)->InventoryItem? {
        if var selectedNode = self.selectedNode() {
            let originalNode = selectedNode.itemName
            selectedNode.removeAllChildren()
            selectedNode.updateWithItem(item)
            if let originalItemName =  originalNode {
                return GameState.shared.inventoryStorage[originalItemName]
            } else {
                return nil
            }

        }
        

        return nil
    }
    
    

}
