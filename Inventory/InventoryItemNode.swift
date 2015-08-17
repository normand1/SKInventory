//
//  TouchableShapeNode.swift
//  Inventory
//
//  Created by David Norman on 8/16/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import SpriteKit

protocol InventoryItemNodeProtocol {
    func InventoryNodeTouched(itemName:String?)
    func resetAllNodesToDefault()
}

var INV_COLOR_SELECTED = UIColor.blueColor()
var INV_COLOR_DESELECTED = UIColor.blackColor()

class InventoryItemNode: SKShapeNode {
    
    var delegate : InventoryItemNodeProtocol?
    var itemName : String?
    var selected = false
    
    override init() {
        super.init()
        self.userInteractionEnabled = true
    }
    
    func updateWithItem(item: InventoryItem?) {
        if let realItem = item {
            self.itemName = realItem.imageName
            var imageNode = SKSpriteNode(imageNamed: self.itemName!)
            self.addChild(imageNode)
            imageNode.size = self.frame.size
            var countLabel = SKLabelNode(text: String(realItem.numberInStack))
            countLabel.fontSize = 20
            countLabel.position = CGPointMake(-15, 5)
            countLabel.fontColor = UIColor.whiteColor()
            countLabel.fontName = "AmericanTypewriter-Bold"
            self.addChild(countLabel)
        } else {
            self.itemName = nil
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        delegate?.resetAllNodesToDefault()
        self.fillColor = INV_COLOR_SELECTED
        self.selected = true
        println("selected: \(self.itemName)")
        delegate?.InventoryNodeTouched(self.itemName)

    }
    
    
    func deselect() {
        self.fillColor = INV_COLOR_DESELECTED
        self.selected = false
    }
    
}
