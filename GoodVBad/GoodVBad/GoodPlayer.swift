//
//  GoodPlayer.swift
//  GoodVBad
//
//  Created by Alexis Saint-Jean on 1/17/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import Foundation

class GoodPlayer: Player {
    var goodAttacks = ["goodAttack1", "goodAttack2"]
    
    
    override init(playerName: String) {
        super.init(playerName: playerName)
        attacks += goodAttacks
        school = "Gryffindor"
    }
    
    
}

