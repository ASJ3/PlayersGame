//
//  Player.swift
//  WizardGame
//
//  Created by Alexis Saint-Jean on 1/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import Foundation

class Player {
    // The name of the various attacks is listed  in an array
    var attacks = ["regAttack1", "regAttack2"]
    var health = 100
    var name = ""
    var school = ""
    
    init (playerName: String) {
        self.name = playerName
    }
    
    func attack()->(message: String, damage: Int) {
        let randomIndex = Int(arc4random_uniform(UInt32(attacks.count)))
        var message = attacks[randomIndex]
        var damage = Int(arc4random_uniform(15))+5
        return (message, damage)
    }
    
    func isAlive()->Bool {
        if health > 0 {
            return true
        } else {
            return false
        }
    }
    
}
