//
//  GameViewController.swift
//  RPG
//
//  Created by Kevin Natera on 10/30/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "BattleScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! BattleScene? {
                
                // Copy gameplay related content over to the scene
                
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                presentScene(sceneNode: sceneNode)
            }
        }
    }

    
    
    //MARK: - Private Funcs

    private func presentScene(sceneNode: SKScene) {
        
        if let view = self.view as! SKView? {
            view.presentScene(sceneNode)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
}


