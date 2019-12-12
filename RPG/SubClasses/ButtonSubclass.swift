//
//  ButtonSubclass.swift
//  RPG
//
//  Created by Kevin Natera on 11/7/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import SpriteKit

class GGButton: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    
    init(defaultButtonImage: String, activeButtonImage: String) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.isHidden = true
        
        super.init()

        addChild(defaultButton)
        addChild(activeButton)
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
