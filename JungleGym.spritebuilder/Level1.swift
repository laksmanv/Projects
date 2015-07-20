//
//  Level1.swift
//  JungleGym
//
//  Created by Laksman Veeravagu on 7/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation


class Level1: CCNode, CCPhysicsCollisionDelegate {
    
    weak var character: CCSprite!
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var ground1 : CCSprite!
    weak var ground2 : CCSprite!
    weak var ground3: CCSprite!
    weak var ground4: CCSprite!
    weak var ground5: CCSprite!
    //test 
  /*  weak var invisibleWall1 : CCSprite!
    weak var invisibleWall2 : CCSprite!
    weak var invisibleWall3: CCSprite!
    weak var invisibleWall4: CCSprite!
    weak var invisibleWall5: CCSprite!
    */
    weak var gap1 : CCSprite!
    weak var gap2 : CCSprite!
    
    var gaps = [CCSprite]()
    var grounds = [CCSprite]()  // initializes an empty array
    var invisibleWalls = [CCSprite]()
    var speed: Int = 225
    var jumped = false
    weak var displayScore: CCLabelTTF!
    var counter: Int = 100
    var score: Int = 100
    var gameOver = false
    weak var retryButton : CCButton!
    weak var gameOverScreen : CCSprite!
    var secondGroundCheck = false
    var minGap: Float = 100.0
    var maxGap: Float = 200.0
    var previousValue: Float = 0
    

    
    func didLoadFromCCB() {
        gamePhysicsNode.collisionDelegate = self
        userInteractionEnabled = true
        grounds.append(ground1)
        grounds.append(ground2)
        grounds.append(ground3)
        grounds.append(ground4)
        grounds.append(ground5)
        
     /*   invisibleWalls.append(invisibleWall1)
        invisibleWalls.append(invisibleWall2)
        invisibleWalls.append(invisibleWall3)
        invisibleWalls.append(invisibleWall4)
        invisibleWalls.append(invisibleWall5)
     */
        
        gaps.append(gap1)
        gaps.append(gap2)
      //  obstacles.append(obstacle1)
     //gamePhysicsNode.debugDraw = true
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, monkeyCollision: CCSprite!, gapCollision: CCSprite!) {
    
        //character.physicsBody.velocity.y=0
        //gamePhysicsNode.gravity.y = 0
        
        character.anchorPoint.x = 1/2
        character.anchorPoint.y = 1/2
        
        ground1.physicsBody.sensor = true
        ground2.physicsBody.sensor = true
        ground2.physicsBody.sensor = true
        ground3.physicsBody.sensor = true
        ground4.physicsBody.sensor = true
        ground5.physicsBody.sensor = true
        
        gap1.physicsBody.sensor = true
        gap2.physicsBody.sensor = true
        
        
        retry()
        
    }
 
    override func fixedUpdate(delta: CCTime) {
        
      //100 to 150
        //+(50*(CCRANDOM_0_1()))
        
      //randomNum = 75
      //println(randomNum)
        //
        
        //var randomNum = (100*(CCRANDOM_0_1()))
        var randomNum = 100
        
        gamePhysicsNode.position.x = gamePhysicsNode.position.x - character.physicsBody.velocity.x * CGFloat(delta)
        //gamePhysicsNode.position.x = character.position.x
        
        
       character.physicsBody.velocity = CGPoint(x: CGFloat(speed), y: character.physicsBody.velocity.y)
    
      
        for ground in grounds {
            let groundWorldPosition = gamePhysicsNode.convertToWorldSpace(ground.position)
           
            let groundScreenPosition = convertToNodeSpace(groundWorldPosition)
            
            //check if ground is off screen by checking if x of groundpositio is less than or equal to -width(ground)
            // groundScreenPosition.x returns to the x coordinate of the position of ground
            
            if groundScreenPosition.x <= (-ground.contentSize.width*CGFloat(ground.scaleX)) {
                
               // var groundPosX = CGFloat(gapSize) + ground.position.x + ground.contentSize.width * 3 * CGFloat(ground.scaleX)
                
                var groundPosX =  grounds.last!.position.x + CGFloat(randomNum) + grounds.last!.boundingBox().width
                
                
                ground.position.y = -349
                grounds.append(grounds.removeAtIndex(0))
               
                
                var randomNum2 = (CCRANDOM_0_1())
                
                var offset: CGFloat
                
                if(randomNum2 <= (1/3))
                {
                    offset = 0
                }else if(randomNum2 <= 2/3){
                    
                    offset = 30
                }else{
                    offset = 20
                }
                
               
                ground.position =  ccp(groundPosX, offset + ground.position.y)
                //invisibleWall.position = ccp(groundPosX, offset + ground.position.y)
           
            }
        }
        
        for gap in gaps {
            let gapWorldPosition = gamePhysicsNode.convertToWorldSpace(gap.position)
            let gapScreenPosition = convertToNodeSpace(gapWorldPosition)
            if gapScreenPosition.x <= (-gap.contentSize.width) {
                gap.position =  ccp(gap.position.x + gap.contentSize.width * 2, gap.position.y)
            }
        }
      /*
        for obstacle in obstacles {
            let obstacleWorldPosition = gamePhysicsNode.convertToWorldSpace(obstacle.position)
            let obstacleScreenPosition = convertToNodeSpace(obstacleWorldPosition)
            if obstacleScreenPosition.x <= (-obstacle.contentSize.width) {
                obstacle.position =  ccp(CGFloat(100) + obstacle.position.x + ground1.contentSize.width * 2, obstacle.position.y)
        
            }
        }*/
        
        counter++
        if(gameOver == false && counter > 10)
        {
            score+=15
            displayScore.string = String (score)
            counter=0
        }
        
    }

    
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        // only runs if character is colliding with another physics object (eg. ground)
        character.physicsBody.eachCollisionPair { (pair) -> Void in
            if (!self.jumped && !self.gameOver) {
                self.character.physicsBody.applyImpulse(CGPoint(x: 0, y: 2000))
                self.jumped = true
                
                NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("resetJump"), userInfo: nil, repeats: false)
            }
        }
    }
    
    func resetJump() {
        jumped = false
    }
    
    override func onEnter() {
        super.onEnter()
        
       //let follow = CCActionFollow(target: character)
       
       //gamePhysicsNode.position = follow.currentOffset()
       //gamePhysicsNode.runAction(follow)
        
       
    }
    
    
    func retry(){
       
        if(gameOver == false)
        {
        speed = 0
        
         gameOver = true
         retryButton.visible = true
        // gameOverScreen.visible = true
         
        }
       
    }
    
    func retryGame() {
        
        let scene = CCBReader.loadAsScene("Level1")
        CCDirector.sharedDirector().presentScene(scene)

    }
    

 
    
    
    
    
}
