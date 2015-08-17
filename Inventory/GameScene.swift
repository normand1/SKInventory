//
//  GameScene.swift
//  Inventory
//
//  Created by David Norman on 8/14/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
                
        InventorySpriteNode.addNewItemNamed(InventoryItemName.hammer_gold)
        InventorySpriteNode.addNewItemNamed(InventoryItemName.hammer_gold)
        InventorySpriteNode.addNewItemNamed(InventoryItemName.flail_bronze)
        InventorySpriteNode.addNewItemNamed(InventoryItemName.ore_emerald)
        InventorySpriteNode.addNewItemNamed(InventoryItemName.ore_emerald)

        
        self.backgroundColor = SKColor.magentaColor()
        self.anchorPoint = CGPointMake(0.5, 0.5)

        var inventorySpriteNode = InventorySpriteNode(size: CGSizeMake(0, 0))
        self.addChild(inventorySpriteNode)
        inventorySpriteNode.showInventory()
        
        var slotsSpriteNode = SlotsSpriteNode(size: CGSizeMake(0, 0))
        self.addChild(slotsSpriteNode)
        slotsSpriteNode.showInventory()
        
        inventorySpriteNode.delegate = slotsSpriteNode
    }
    
//    
//    override func touchesBegan(touches: Set<NSObject>,
//        withEvent event: UIEvent) {
//            let touch = touches.first as! UITouch
//             var nodes = nodesAtPoint(touch.locationInView(InventorySpriteNode.view))
//            for var i = 0; i < nodes.count; i++ {
//                if var tempNode = nodes[i] as? SKShapeNode {
//                    println("name: \(tempNode.name)")
//                    tempNode.fillColor = UIColor.whiteColor()
//                }
//
//            }

            
//    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
