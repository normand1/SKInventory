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
        
        self.backgroundColor = SKColor.magentaColor()
        self.anchorPoint = CGPointMake(0.5, 0.5)

        var wholeInventoryNode = SKSpriteNode()
        
        let columns = 10 //change number of columns (rows are auto-calced based on size of view)
    
        let squareWidth = self.frame.size.width / CGFloat(columns)
        
        let rows = Int(self.frame.size.height / squareWidth)
        wholeInventoryNode.size = CGSizeMake(self.frame.size.width, CGFloat(rows) * squareWidth)
        wholeInventoryNode.anchorPoint = CGPointMake(0.5,0.5)
        wholeInventoryNode.position = CGPointMake(0, 0)
        wholeInventoryNode.color = UIColor.greenColor()
        
        self.addChild(wholeInventoryNode)

        for var i = 0; i < columns; i++ {
            for var j = 0; j < rows; j++ {
                var inventoryItem = SKShapeNode(rectOfSize: CGSize(width: squareWidth, height: squareWidth))
                var updatedX = wholeInventoryNode.frame.origin.x + (CGFloat(inventoryItem.frame.size.width) / CGFloat(2)) + squareWidth * CGFloat(i)
                var updatedY = CGFloat(wholeInventoryNode.frame.size.height - (CGFloat(inventoryItem.frame.size.height))) / CGFloat(2) - (squareWidth * CGFloat(j))
                inventoryItem.position = CGPoint(x:updatedX, y:updatedY )
                inventoryItem.fillColor = UIColor.blackColor()
                inventoryItem.strokeColor = UIColor.whiteColor()
                inventoryItem.lineWidth = 2.0
                
                wholeInventoryNode.addChild(inventoryItem)
                
                var imageNode = SKSpriteNode(imageNamed: "sword_diamond")
                inventoryItem.addChild(imageNode)
                imageNode.size = inventoryItem.frame.size
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
