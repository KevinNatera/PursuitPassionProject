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
    
    lazy var enemyHPLabel: SKAdvancedLabelNode = {
        let label = SKAdvancedLabelNode(fontNamed: "Optima-ExtraBlack")
        label.fontSize = CGFloat(15.0)
        label.fontColor = .black
        label.position = CGPoint(x: -160, y: 275)
        label.text = "Enemy HP:  \(Int(enemy.currentHealth)) / \(Int(enemy.maxHealth))"
        label.horizontalAlignmentMode = .left
        return label
    }()
    
    lazy var menuBackground: SKShapeNode = {
        let background = SKShapeNode(rect: CGRect(x: -175, y: -300, width: 350, height: 200))
        background.fillColor = .blue
        background.zPosition = -10
        return background
    }()
    
    lazy var resetButton: SKSpriteNode = {
        let button = SKSpriteNode(imageNamed: "retry")
        button.position = CGPoint(x: 0, y: 70)
        button.size = CGSize(width: 25, height: 25)
        button.alpha = 0
        button.isPaused = true
        return button
    }()
    
    lazy var retryLabel: SKAdvancedLabelNode = {
        let label = SKAdvancedLabelNode(fontNamed: "Optima-ExtraBlack")
        label.fontSize = CGFloat(15.0)
        label.fontColor = .black
        label.position = CGPoint(x: 0, y: 100)
        label.alpha = 0
        label.horizontalAlignmentMode = .center
        return label
    }()
    
    lazy var messageLabel: SKAdvancedLabelNode = {
        let label = SKAdvancedLabelNode(fontNamed: "Optima-ExtraBlack")
        label.fontSize = CGFloat(15.0)
        label.fontColor = .black
        label.text = "BATTLE START!"
        label.position = CGPoint(x: 0, y: 150)
        label.horizontalAlignmentMode = .center
        return label
    }()
    
    lazy var infoLabel: SKSpriteNode = {
        let background = SKSpriteNode(color: .gray , size: CGSize(width: 160, height: 70))
        background.zPosition = 4
        background.position = CGPoint(x: 0, y: 0)
        background.alpha = 0
        return background
        
    }()
    
    
    
    //MARK: - Menu Button Nodes
    
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
    
    lazy var backButton: SKSpriteNode = {
        let button = SKSpriteNode(imageNamed: "backButton")
        button.position = CGPoint(x: 0, y: -115)
        button.size = CGSize(width: 30, height: 30)
        button.isHidden = true
        button.isPaused = true
        return button
    }()
    
    
    //MARK: - Ability Button Nodes
    lazy var refreshButton: GGButton = {
        let button = GGButton(defaultButtonImage: "RefreshButton", activeButtonImage: "PressedRefreshButton")
        button.defaultButton.position = CGPoint(x: -90, y: -160)
        button.defaultButton.size = CGSize(width: 150, height: 60)
        button.activeButton.position = CGPoint(x: -90, y: -160)
        button.activeButton.size = CGSize(width: 150, height: 60)
        button.isPaused = true
        button.isHidden = true
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
        label.alpha = 0
        label.zPosition = 5
        label.horizontalAlignmentMode = .center
        return label
    }()
    
    lazy var enemyTargetArrow: SKSpriteNode = {
        let arrow = SKSpriteNode(imageNamed: "downArrow")
        arrow.position = CGPoint(x: -140, y: 50)
        arrow.size = CGSize(width: 30, height: 30)
        return arrow
    }()
    
    lazy var targetLabel: SKAdvancedLabelNode = {
        let label = SKAdvancedLabelNode(fontNamed: "Optima-ExtraBlack")
        label.fontSize = CGFloat(15.0)
        label.fontColor = .black
        label.position = CGPoint(x: -140, y: 70)
        label.text = "Enemy"
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
        label.alpha = 0
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
            
            if attackButton.contains(location) && !attackButton.isPaused {
                highlightAttackButton()
            }
            
            if abilityButton.contains(location) && !abilityButton.isPaused {
                highlightAbilityButton()
            }
            
            if itemButton.contains(location) && !itemButton.isPaused {
                highlightItemButton()
            }
            
            if refreshButton.contains(location) && !refreshButton.isPaused {
                highlightRefreshButton()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location: CGPoint = touch.location(in: self)
            
            if attackButton.contains(location) && !attackButton.isPaused {
                
                highlightAttackButton()
                updateInfoLabel(location: location, text: "Perform a basic attack that deals \(Int(hero.strength)) damage.")
                
            } else if abilityButton.contains(location) && !abilityButton.isPaused{
                
                highlightAbilityButton()
                updateInfoLabel(location: location, text: "Switch to ability commands")
            
            } else if itemButton.contains(location) && !itemButton.isPaused {
                
                highlightItemButton()
                updateInfoLabel(location: location, text: "Waste your turn because I didn't implement this yet")
                
            } else if refreshButton.contains(location) && !refreshButton.isPaused {
                
                highlightRefreshButton()
                updateInfoLabel(location: location, text: "Chant for one turn before restoring \(Int(hero.strength * 4)) HP. Consumes 25 NRG.")
            } else {
                revertButtons()
                infoLabel.alpha = 0
            }
            
        }
    }
    
    //MARK: - Touches Ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        infoLabel.alpha = 0
        
        for touch in touches {
            
            let location: CGPoint = touch.location(in: self)
            
            revertButtons()
            
            if resetButton.contains(location) && !resetButton.isPaused {
                reset()
            }
            
            if backButton.contains(location) && !backButton.isPaused {
                switchToCommands()
            }
            
            if attackButton.contains(location) && !attackButton.isPaused {
                battlePhase(attackType: "attack", abilityType: nil, chantTurns: nil)
            }
            
            if abilityButton.contains(location) && !abilityButton.isPaused {
                switchToAbilities()
            }
            
            if itemButton.contains(location) && !itemButton.isPaused {
                battlePhase(attackType: "items", abilityType: nil, chantTurns: nil)
            }
            
            if refreshButton.contains(location) && !refreshButton.isPaused {
                heroChargesRefresh()
            }
            
        }
    }
    
    
    //MARK: - Private funcs
    
    private func addChildren() {
        addChild(hero)
        addChild(enemy)
        addChild(resetButton)
        addChild(retryLabel)
        addChild(messageLabel)
        addChild(menuBackground)
        addChild(attackButton)
        addChild(abilityButton)
        addChild(backButton)
        addChild(itemButton)
        addChild(refreshButton)
        addChild(enemyNumberLabel)
        addChild(enemyTargetArrow)
        addChild(targetLabel)
        addChild(infoLabel)
        addChild(statusBackground)
        addChild(enemyHPLabel)
        addChild(enemyHealthBar)
        addChild(enemyHealthBarDamage)
        addChild(heroHealthBar)
        addChild(heroHealthBarDamage)
        addChild(heroNumberLabel)
        addChild(heroEnergyBar)
        addChild(heroEnergyBarDepletion)
        
        disableCommandButtons()
        messageLabel.shake(delay: 0.2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
            self.showMessage(text: "Select a command!")
            self.enableCommandButtons()
        }
    }
    
    private func showMessage(text: String) {
        messageLabel.alpha = 1
        messageLabel.text = "\(text)"
    }
    
    
    //MARK: - Button Funcs
    
    private func updateInfoLabel(location: CGPoint, text: String) {
        infoLabel.removeAllChildren()
        infoLabel.position = CGPoint(x: location.x, y: location.y + 40)
        infoLabel.alpha = 1
        
        let label = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        label.zPosition = 5
        label.fontColor = .black
        label.fontSize = 12
        label.name = "infoLabel"
        label.numberOfLines = 3
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.preferredMaxLayoutWidth = 150
        label.text = text
        infoLabel.addChild(label)
    }
    
    var showAbilities = false
    
    private func switchToAbilities() {
        attackButton.isHidden = true
        abilityButton.isHidden = true
        itemButton.isHidden = true
        disableCommandButtons()
        
        showAbilities = true
        
        enableAbilityButtons()
    }
    
    private func switchToCommands() {
        attackButton.isHidden = false
        abilityButton.isHidden = false
        itemButton.isHidden = false
        enableCommandButtons()
        showAbilities = false
        
        disableAbilityButtons()
    }
    
    
    
    
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
    
    private func highlightRefreshButton() {
        refreshButton.defaultButton.isHidden = true
        refreshButton.activeButton.isHidden = false
    }
    
    
    private func revertButtons() {
        attackButton.defaultButton.isHidden = false
        attackButton.activeButton.isHidden = true
        abilityButton.defaultButton.isHidden = false
        abilityButton.activeButton.isHidden = true
        itemButton.defaultButton.isHidden = false
        itemButton.activeButton.isHidden = true
        refreshButton.defaultButton.isHidden = false
        refreshButton.activeButton.isHidden = true
    }
    
    private func enableCommandButtons() {
        attackButton.isPaused = false
        abilityButton.isPaused = false
        itemButton.isPaused = false
    }
    
    private func disableCommandButtons() {
        attackButton.isPaused = true
        abilityButton.isPaused = true
        itemButton.isPaused = true
    }
    
    
    private func enableAbilityButtons() {
        backButton.isHidden = false
        backButton.isPaused = false
        refreshButton.isPaused = false
        refreshButton.isHidden = false
    }
    
    private func disableAbilityButtons() {
        backButton.isHidden = true
        backButton.isPaused = true
        refreshButton.isPaused = true
        refreshButton.isHidden = true
    }
    
    
    
    
    //MARK: - Battle Funcs
    
    private func reset() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
            self.resetButton.alpha = 0
            self.resetButton.isPaused = true
            self.retryLabel.alpha = 0
            self.switchToCommands()
            self.messageLabel.text = "BATTLE START!"
            self.messageLabel.shake(delay: 0.2)
            self.hero.currentHealth = self.hero.maxHealth
            self.hero.currentEnergy = self.hero.maxEnergy
            self.animateHero()
            self.animateHeroHealthBar()
            self.enemy.currentHealth = self.enemy.maxHealth
            self.animateEnemy()
            self.animateHeroHealthBar()
            self.animateHeroEnergyBar(energyCost: 0)
            self.enableCommandButtons()
        }
    }
    
    private func battlePhase(attackType: String, abilityType: String?, chantTurns: Int?) {
        disableCommandButtons()
        
        //Hero Phase
        
        showMessage(text: "Hero's turn")
        
        var turnsLeft = 0
        
        switch attackType {
        case "attack":
            heroAttacks()
        case "ability":
            if let abilityType = abilityType, let chantTurns = chantTurns {
                
                turnsLeft = chantTurns
                if chantTurns <= 0 {
                    switch abilityType {
                    case "refresh":
                        heroCastsRefresh()
                    default:
                        break
                    }
                } else {
                    showMessage(text: "Chanting...")
                    break
                }
            }
        default:
            break
        }
        self.animateEnemy()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.enemyNumberLabel.alpha = 0
            
            
            //Villain Phase
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if self.enemy.currentHealth > 0 {
                    
                    self.enemyAttacks()
                    self.animateHeroHealthBar()
                    self.showMessage(text: "Enemy's turn")
                    
                    //Reset
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.heroNumberLabel.alpha = 0
                        if self.hero.currentHealth > 0 {
                            
                            self.messageLabel.text = "Select a command!"
                            
                            
                            self.enableCommandButtons()
                            
                            
                            if turnsLeft > 0 {
                                self.battlePhase(attackType: "ability", abilityType: abilityType , chantTurns: chantTurns! - 1)
                            }
                        }
                    }
                } else {
                    self.disableCommandButtons()
                }
            }
        }
    }
    
    //MARK: - Command Funcs
    
    private func heroAttacks() {
        let attackPower = hero.strength - enemy.durability
        enemy.currentHealth -= attackPower
        enemyNumberLabel.text = "\(Int(attackPower))!"
        enemyNumberLabel.fontColor = .black
        enemyNumberLabel.alpha = 1.0
        enemyNumberLabel.sequentiallyBouncingZoom(delay: 0.2, infinite: false)
        enemy.texture = enemyDamaged
    }
    
    private func heroChargesRefresh() {
        if hero.currentEnergy >= 25 {
            hero.currentEnergy -= 25
            hero.condition = .chanting
            animateHero()
            showMessage(text: "Chanting...")
            switchToCommands()
            battlePhase(attackType: "ability", abilityType: "refresh", chantTurns: 1)
            animateHeroEnergyBar(energyCost: 25)
        } else {
            showMessage(text: "Not enough energy!")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showMessage(text: "Select a command!")
            }
        }
    }
    
    private func heroCastsRefresh() {
        let heal = hero.strength * 4
        if (hero.currentHealth + heal) > hero.maxHealth {
            heroNumberLabel.text = "+\(Int(hero.maxHealth - hero.currentHealth)) HP!"
            hero.currentHealth = hero.maxHealth
        } else {
            hero.currentHealth += heal
            heroNumberLabel.text = "+\(Int(heal)) HP!"
        }
    
        hero.condition = .normal
        heroNumberLabel.fontColor = .green
        heroNumberLabel.alpha = 1
        heroNumberLabel.sequentiallyBouncingZoom(delay: 0.2, infinite: false)
        showMessage(text: "Hero casts Refresh!")
        
        
        animateHeroHealthBar()
        animateHero()
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
                    self.disableCommandButtons()
                    self.retryLabel.alpha = 1
                    self.retryLabel.text = "Try again?"
                    self.messageLabel.alpha = 1
                    self.messageLabel.text = "GAME OVER SCRUBBBB"
                    self.messageLabel.shake(delay: 0.2)
                    self.resetButton.alpha = 1
                    self.resetButton.isPaused = false
                    
                }
            }
        }
        
    }
    
    private func animateHeroHealthBar() {
        if hero.currentHealth > hero.maxHealth {
            heroHealthBar.alpha = 1
            heroHealthBar.size = CGSize(width: 50, height: 15)
        } else if hero.currentHealth > 0 {
            heroHealthBar.alpha = 1
            heroHealthBar.size = CGSize(width: (hero.currentHealth/hero.maxHealth) * 50, height: 15)
        } else {
            heroHealthBar.alpha = 0
        }
    }
    
    private func animateHeroEnergyBar(energyCost: Double) {
        
        if hero.currentEnergy > hero.maxEnergy {
            heroEnergyBar.alpha = 1
            heroEnergyBar.size = CGSize(width: 50, height: 15)
        } else if hero.currentEnergy > 0 {
            heroEnergyBar.alpha = 1
            heroEnergyBar.size = CGSize(width: (hero.currentEnergy/hero.maxEnergy) * 50, height: 15)
            heroNumberLabel.fontColor = .blue
            heroNumberLabel.text = "-\(Int(energyCost)) NRG"
            heroNumberLabel.alpha = 1.0
            if energyCost == 0 {
                heroNumberLabel.alpha = 0
            }
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
                self.disableCommandButtons()
                self.retryLabel.alpha = 1
                self.retryLabel.text = "Restart Battle?"
                self.messageLabel.alpha = 1
                self.messageLabel.text = "VICTORY!"
                self.messageLabel.shake(delay: 0.2)
                self.resetButton.alpha = 1
                self.resetButton.isPaused = false
            }
        }
        
        animateEnemyHealthBar()
        
    }
    
    private func animateEnemyHealthBar() {
        
        
        enemyHPLabel.text = "Enemy HP: \(Int(enemy.currentHealth)) / \(Int(enemy.maxHealth))"
        
        if enemy.currentHealth > enemy.maxHealth {
            enemyHealthBar.alpha = 1
            enemyHealthBar.size = CGSize(width: 50, height: 15)
        } else if enemy.currentHealth > 0 {
            enemyHealthBar.alpha = 1
            enemyHealthBar.size = CGSize(width: (enemy.currentHealth/enemy.maxHealth) * 50, height: 15)
            
        } else {
            enemyHealthBar.alpha = 0
            enemyHPLabel.text = "Enemy HP: 0 / \(Int(enemy.maxHealth))"
        }
    }
    
}


