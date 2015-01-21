//
//  GoodPlayer.swift
//  WizardGame
//
//  Created by Alexis Saint-Jean on 1/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import Foundation

class GoodPlayer: Player {
    var goodAttacks = ["Conjunctivitis", "Deprimo"]
    
    
    override init(playerName: String) {
        super.init(playerName: playerName)
        attacks += goodAttacks
        school = "Gryffindor"
    }
    
    
}
