//
//  GameScene.swift
//  Sprite Actions
//
//  Created by Colin Whiteford on 9/24/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var lastUpdateTime: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    class ActionableSprite
    {
        init(sprite: SKSpriteNode, position: CGPoint, scale: CGFloat, action: SKAction, scene: SKScene)
        {
            self.sprite = sprite
            self.sprite.position = position
            self.sprite.setScale(scale)
            scene.addChild(sprite)
            self.action = SKAction.sequence([SKAction.run {self.UpdateInteractionState(newState: false)}, action, SKAction.run {self.UpdateInteractionState(newState: true)}])
        }
        var sprite: SKSpriteNode
        var action: SKAction = SKAction()
        var canBeInteractedWith: Bool = true
        func UpdateInteractionState(newState: Bool)
        {
            canBeInteractedWith = newState
        }
        func CheckTouchAndRunAction(touchLocation: CGPoint)
        {
            if(!canBeInteractedWith){return;}
            if(!sprite.frame.contains(touchLocation)){return;}
            sprite.run(action)
        }
    }
    
    var interactiveSprites: [ActionableSprite] = []

    
    //Awake
    override func didMove(to view: SKView)
    {
        backgroundColor = SKColor.black
        let scaleDownAction: SKAction = SKAction.scale(by: 0.5, duration: 2)
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: -50, y: 0), scale: CGFloat(0.5), action: scaleDownAction, scene: self))
        let scaleUpAndDown: SKAction = SKAction.sequence([SKAction.scale(by: 2, duration: 0.5), SKAction.scale(by: 0.5, duration: 0.5)])
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: 50, y: 0), scale: CGFloat(0.5), action: scaleUpAndDown, scene: self))
        let moveUp: SKAction = SKAction.moveBy(x: 0, y: 50, duration: 1)
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: 150, y: 0), scale: CGFloat(0.5), action: moveUp, scene: self))
        let moveUpAndDown: SKAction = SKAction.sequence([SKAction.moveBy(x: 0, y: 50, duration: 1), SKAction.moveBy(x: 0, y: -50, duration: 1)])
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: 250, y: 0), scale: CGFloat(0.5), action: moveUpAndDown, scene: self))
        let removeFromParent: SKAction = SKAction.removeFromParent()
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: 350, y: 0), scale: CGFloat(0.5), action: removeFromParent, scene: self))
        let newTexture = SKTexture(imageNamed: "zombie4")
        let changeTexture: SKAction = SKAction.setTexture(newTexture)
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: 450, y: 0), scale: CGFloat(0.5), action: changeTexture, scene: self))
        let fadeAlpha: SKAction = SKAction.fadeAlpha(to: 0, duration: 1)
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: -150, y: 0), scale: CGFloat(0.5), action: fadeAlpha, scene: self))
        let rotateOnce: SKAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1)
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: -250, y: 0), scale: CGFloat(0.5), action: rotateOnce, scene: self))
        let rotateThreeTimes: SKAction = SKAction.rotate(byAngle: CGFloat.pi * 6, duration: 3)
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: -350, y: 0), scale: CGFloat(0.5), action: rotateThreeTimes, scene: self))
        let playSound: SKAction = SKAction.playSoundFileNamed("win", waitForCompletion: false)
        interactiveSprites.append(ActionableSprite(sprite: SKSpriteNode(imageNamed: "zombie1"), position: CGPoint(x: -450, y: 0), scale: CGFloat(0.5), action: playSound, scene: self))
        
        
    }
    //Update
    override func update(_ currentTime: TimeInterval)
    {
        if lastUpdateTime > 0
        {
            deltaTime = currentTime - lastUpdateTime
        }
        else
        {
            deltaTime = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self)
        for interactiveSprite in interactiveSprites {
            interactiveSprite.CheckTouchAndRunAction(touchLocation: touchLocation)
        }
    }


    
}
