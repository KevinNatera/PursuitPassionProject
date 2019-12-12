//
//  GameScene.swift
//  RPG
//
//  Created by Kevin Natera on 10/30/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class BattleScene: SKScene {
    
    //MARK: - Character Nodes
    
    lazy var hero: CharacterSprite = {
        let sprite = CharacterSprite(imageNamed: "Cecil_base_ready")
        sprite.position = CGPoint(x: frame.minX + 330, y: frame.minY + 330)
        sprite.strength = 25
        sprite.currentHealth = sprite.maxHealth
        return sprite
    }()
    
    let heroDefault = SKTexture(imageNamed: "Cecil_base_ready")
    let chant1 = SKTexture(imageNamed: "Cecil_base_chant_1")
    let chant2 = SKTexture(imageNamed: "Cecil_base_chant_2")
    let heroDamaged = SKTexture(imageNamed: "Cecil_base_damage")
    let hurtHero = SKTexture(imageNamed: "Cecil_base_fatal")
    let deadHero = SKTexture(imageNamed: "Cecil_base_dead")
    let victoryPose = SKTexture(imageNamed: "Cecil_base_hands_up")
    
    
    
    lazy var enemy: CharacterSprite = {
        let sprite = CharacterSprite(imageNamed: "Golbez_base_ready")
        sprite.position = CGPoint(x: frame.minX + 70, y: frame.minY + 330)
        sprite.strength = 25
        sprite.maxHealth = 100
        sprite.currentHealth = sprite.maxHealth
        sprite.xScale = -1
        return sprite
    }()
    
    let enemyDefault = SKTexture(imageNamed: "Golbez_base_ready")
    let hurtEnemy = SKTexture(imageNamed: "Golbez_base_fatal")
    let enemyDamaged = SKTexture(imageNamed: "Golbez_base_damage")
    let deadEnemy = SKTexture(imageNamed: "Golbez_base_dead")
    let enemyVictoryPose = SKTexture(imageNamed: "Golbez_base_hands_up")
    
    //MARK: - UI Nodes
    
    lazy var statusBackground: SKShapeNode = {
        let background = SKShapeNode(rect: CGRect(x: -175, y: 200, width: 350, height: 100))
        background.fillColor = .blue
        background.zPosition = -10
        return background
    }()
    
    lazy var menuBackground: SKShapeNode = {
        let background = SKShapeNode(rect: CGRect(x: -175, y: -300, width: 350, height: 200))
        background.fillColor = .blue
        background.zPosition = -10
        return background
    }()
    
    lazy var attackButton: GGButton = {
        let button = GGButton(defaultButtonImage: "AttackButton", activeButtonImage: "PressedAttackButton")
        button.defaultButton.position = CGPoint(x: -90, y: -160)
        button.defaultButton.size = CGSize(width: 150, height: 60)
        button.activeButton.position = CGPoint(x: -90, y: -160)
        button.activeButton.size = CGSize(width: 150, height: 60)
        return button
    }()
    
    lazy var abilityButton: GGButton = {
        let button = GGButton(defaultButtonImage: "AbilityButton", activeButtonImage: "PressedAbilityButton")
        button.defaultButton.position = CGPoint(x: 90, y: -160)
        button.defaultButton.size = CGSize(width: 150, height: 60)
        button.activeButton.position = CGPoint(x: 90, y: -160)
        button.activeButton.size = CGSize(width: 150, height: 60)
        return button
    }()
    
    lazy var itemButton: GGButton = {
        let button = GGButton(defaultButtonImage: "ItemButton", activeButtonImage: "PressedItemButton")
        button.defaultButton.position = CGPoint(x: -90, y: -240)
        button.defaultButton.size = CGSize(width: 150, height: 60)
        button.activeButton.position = CGPoint(x: -90, y: -240)
        button.activeButton.size = CGSize(width: 150, height: 60)
        return button
    }()
    
    
    //MARK: - Villain UI Nodes
    
    lazy var enemyHealthBar: SKSpriteNode = {
        let bar = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 15))
        bar.position = CGPoint(x: -140, y: 25)
        bar.zPosition = -1
        return bar
    }()
    
    lazy var enemyHealthBarDamage: SKSpriteNode = {
        let bar = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 15))
        bar.position = CGPoint(x: -140, y: 25)
        bar.zPosition = -2
        return bar
    }()
    
    lazy var enemyNumberLabel: SKAdvancedLabelNode = {
        let label = SKAdvancedLabelNode(fontNamed: "Optima-ExtraBlack")
        label.fontSize = CGFloat(15.0)
        label.fontColor = .black
        label.position = CGPoint(x: -90, y: -10)
        label.alpha = 0.0
        label.zPosition = 5
        label.horizontalAlignmentMode = .center
        return label
    }()
    
    
    //MARK: - Hero UI Nodes
    lazy var heroHealthBar: SKSpriteNode = {
        let bar = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 15))
        bar.position = CGPoint(x: 125, y: 35)
        bar.zPosition = -1
        return bar
    }()
    
    lazy var heroHealthBarDamage: SKSpriteNode = {
        let bar = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 15))
        bar.position = CGPoint(x: 125, y: 35)
        bar.zPosition = -2
        return bar
    }()
    
    lazy var heroEnergyBar: SKSpriteNode = {
        let bar = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 15))
        bar.position = CGPoint(x: 125, y: 15)
        bar.zPosition = -1
        return bar
    }()
    
    lazy var heroEnergyBarDepletion: SKSpriteNode = {
        let bar = SKSpriteNode(color: .black, size: CGSize(width: 50, height: 15))
        bar.position = CGPoint(x: 125, y: 15)
        bar.zPosition = -2
        return bar
    }()
    
    lazy var heroNumberLabel: SKAdvancedLabelNode = {
        let label = SKAdvancedLabelNode(fontNamed: "Optima-ExtraBlack")
        label.fontSize = CGFloat(15.0)
        label.fontColor = .black
        label.position = CGPoint(x: 65, y: -10)
        label.alpha = 0.0
        label.zPosition = 5
        label.horizontalAlignmentMode = .center
        return label
    }()
    
    
    
    
    
    //MARK: - Ovveride Funcs
    override func didMove(to view: SKView) {
        addChildren()
    }
    
    override func sceneDidLoad() {
        scene?.backgroundColor = .white
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    //MARK: - Touch Funcs
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location: CGPoint = touch.location(in: self)
            
            if attackButton.contains(location) {
                highlightAttackButton()
            }
            
            if abilityButton.contains(location) {
                highlightAbilityButton()
            }
            
            if itemButton.contains(location) {
                highlightItemButton()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location: CGPoint = touch.location(in: self)
            
            if attackButton.contains(location) {
                highlightAttackButton()
            } else if abilityButton.contains(location){
                highlightAbilityButton()
            } else if itemButton.contains(location){
                highlightItemButton()
            } else {
                revertButtons()
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        for touch in touches {
            
            let location: CGPoint = touch.location(in: self)
            
            revertButtons()
            
            if attackButton.contains(location) {
                battlePhase()
                animateEnemy()
                animateHero()
            }
            
            if abilityButton.contains(location) {
                //ability code!
            }
            
            if itemButton.contains(location) {
                //item code!
            }
            
            
        }
    }
    
    
    //MARK: - Private funcs
    
    private func addChildren() {
        addChild(enemy)
        addChild(hero)
        addChild(menuBackground)
        addChild(attackButton)
        addChild(abilityButton)
        addChild(itemButton)
        addChild(enemyNumberLabel)
        addChild(statusBackground)
        addChild(enemyHealthBar)
        addChild(enemyHealthBarDamage)
        addChild(heroHealthBar)
        addChild(heroHealthBarDamage)
        addChild(heroNumberLabel)
        addChild(heroEnergyBar)
        addChild(heroEnergyBarDepletion)
    }
    
    
    //MARK: - Button Funcs
    private func highlightAttackButton() {
        attackButton.defaultButton.isHidden = true
        attackButton.activeButton.isHidden = false
    }
    
    private func highlightAbilityButton() {
        abilityButton.defaultButton.isHidden = true
        abilityButton.activeButton.isHidden = false
    }
    
    private func highlightItemButton() {
        itemButton.defaultButton.isHidden = true
        itemButton.activeButton.isHidden = false
    }
    
    
    private func revertButtons() {
        attackButton.defaultButton.isHidden = false
        attackButton.activeButton.isHidden = true
        abilityButton.defaultButton.isHidden = false
        abilityButton.activeButton.isHidden = true
        itemButton.defaultButton.isHidden = false
        itemButton.activeButton.isHidden = true
    }
    
    private func enableButtons() {
        attackButton.isUserInteractionEnabled = false
        abilityButton.isUserInteractionEnabled = false
        itemButton.isUserInteractionEnabled = false
    }
    
    private func disableButtons() {
        attackButton.isUserInteractionEnabled = true
        abilityButton.isUserInteractionEnabled = true
        itemButton.isUserInteractionEnabled = true
    }
    
    
    
    
    //MARK: - Battle Funcs
    
    private func battlePhase() {
        disableButtons()
        
        //Hero Phase
        
        heroAttacks()
        
        print("\(hero.strength) Hero Strength")
        print("\(enemy.durability) Enemy Def")
        print("\(hero.strength - enemy.durability) Damage Dealt")
        print("\(enemy.currentHealth) Enemy HP left")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.enemyNumberLabel.alpha = 0.0
            
            
            //Villain Phase
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if self.enemy.currentHealth > 0 {
                    
                    self.enemyAttacks()
                    self.animateHeroHealthBar()
                    
                    print("\(self.enemy.strength) Villain Strength")
                    print("\(self.hero.durability) Hero Def")
                    print("\(self.enemy.strength - self.hero.durability) Villain Damage Dealt")
                    print("\(self.hero.currentHealth) Hero HP left")
                    //Reset
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.heroNumberLabel.alpha = 0
                        if self.hero.currentHealth > 0 {
                            self.enableButtons()
                        }
                    }
                } else {
                    self.disableButtons()
                }
            }
        }
    }
    
    private func heroAttacks() {
        let attackPower = hero.strength - enemy.durability
        enemy.currentHealth -= attackPower
        
        enemyNumberLabel.text = "\(Int(attackPower))!"
        enemyNumberLabel.alpha = 1.0
        enemyNumberLabel.sequentiallyBouncingZoom(delay: 0.2, infinite: false)
        enemy.texture = enemyDamaged
    }
    
    private func enemyAttacks() {
        let villainAttackPower = enemy.strength - hero.durability
        hero.currentHealth -= villainAttackPower
        heroNumberLabel.text = "\(Int(villainAttackPower))!"
        heroNumberLabel.fontColor = .black
        heroNumberLabel.alpha = 1
        heroNumberLabel.sequentiallyBouncingZoom(delay: 0.2, infinite: false)
        
        hero.removeAllActions()
        hero.texture = heroDamaged
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animateHero()
        }
        
    }
    
    
    //MARK: - Hero Animations
    
    //called last
    private func animateHero() {
        
        if hero.currentHealth <= 0 {
            hero.healthCondition = .dead
            hero.condition = .normal
        } else if hero.currentHealth < (hero.maxHealth) * 0.3 {
            hero.healthCondition = .hurt
        } else {
            hero.healthCondition = .healthy
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.hero.condition == .chanting {
                self.hero.removeAllActions()
                self.hero.run(.repeatForever(.animate(with: [self.chant1,self.chant2], timePerFrame: 0.33)))
            } else {
                switch self.hero.healthCondition {
                case .healthy:
                    self.hero.removeAllActions()
                    self.hero.texture = self.heroDefault
                case .hurt:
                    self.hero.removeAllActions()
                    self.hero.texture = self.hurtHero
                case .dead:
                    self.hero.removeAllActions()
                    self.hero.texture = self.deadHero
                    self.enemy.texture = self.enemyVictoryPose
                    self.disableButtons()
                }
            }
        }
        
    }
    
    private func animateHeroHealthBar() {
        if hero.currentHealth > 0 {
            heroHealthBar.size = CGSize(width: (hero.currentHealth/hero.maxHealth) * 50, height: 15)
        } else {
            heroHealthBar.alpha = 0
        }
    }
    
    private func animateHeroEnergyBar(energyCost: Double) {
        if hero.currentEnergy > 0 {
            heroEnergyBar.size = CGSize(width: (hero.currentEnergy/hero.maxEnergy) * 50, height: 15)
            heroNumberLabel.fontColor = .blue
            heroNumberLabel.text = "\(energyCost) NRG"
            heroNumberLabel.alpha = 1.0
            heroNumberLabel.sequentiallyBouncingZoom(delay: 0.1, infinite: false)
        } else {
            heroEnergyBar.alpha = 0
        }
    }
    
    //MARK: - Villain Animations
    
    private func animateEnemy() {
        
        if enemy.currentHealth <= 0 {
            enemy.healthCondition = .dead
            enemy.condition = .normal
        } else if enemy.currentHealth < (enemy.maxHealth) * 0.3 {
            enemy.healthCondition = .hurt
        } else {
            enemy.healthCondition = .healthy
        }
        
        print("Villain health condition: \(enemy.healthCondition)")
        
        
        enemy.texture = enemyDamaged
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            switch self.enemy.healthCondition {
            case .healthy:
                self.enemy.texture = self.enemyDefault
            case .hurt:
                self.enemy.texture = self.hurtEnemy
            case .dead:
                self.enemy.texture = self.deadEnemy
                self.hero.removeAllActions()
                self.hero.texture = self.victoryPose
                self.disableButtons()
            }
        }
        
        if enemy.currentHealth > 0 {
            enemyHealthBar.size = CGSize(width: (enemy.currentHealth/enemy.maxHealth) * 50, height: 15)
        } else {
            enemyHealthBar.alpha = 0
        }
    }
}


