//
//  SpriteNodeSubClass.swift
//  RPG
//
//  Created by Kevin Natera on 11/8/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import SpriteKit


enum StatusProblem {
    case none
    case poison
    case paralysis
}

enum HealthCondition {
    case healthy
    case hurt
    case dead
}

enum Condition {
    case normal
    case attacking
    case chanting
    case resting
}


class CharacterSprite: SKSpriteNode {
    
    var shouldAnimate = false
    var condition: Condition = .normal
    var healthCondition: HealthCondition = .healthy
    var statusProblem: StatusProblem = .none
    var maxHealth = 100.0
    var currentEnergy = 100.0
    var maxEnergy = 100.0
    var currentHealth = 100.0
    var strength = 0.0
    var durability = 0.0
    var reflex = 0.0
 
    
}
