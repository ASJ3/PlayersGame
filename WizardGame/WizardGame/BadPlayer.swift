//
//  BadPlayer.swift
//  WizardGame
//
//  Created by Alexis Saint-Jean on 1/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import Foundation

class BadPlayer: Player {
    var badAttacks = ["badAttack1", "badAttack2"]
    
    override init(playerName: String) {
        super.init(playerName: playerName)
        attacks += badAttacks
        school = "Slytherin"
    }
    
}
