// Playground - noun: a place where people can play

import UIKit

class Player {
    
    var attacks = ["gralAttack1", "gralAttack2", "gralAttack3"]
    
    func attack()->(message: String, damage: Int) {
        var message = ""
        var damage = 0
        return (message, damage)
    }
    
}

class GoodPlayer: Player {
    var goodAttacks = ["goodAttack1", "goodAttack2", "goodAttack3"]
    
    override init() {
        super.init()
        attacks += goodAttacks
    }
    
    
}

class BadPlayer: Player {
    var badAttacks = ["badAttack1", "badAttack2", "badAttack3"]
    
    override init() {
        super.init()
        attacks += badAttacks
    }
    
}

class Match {
    
    
}




