// Playground - noun: a place where people can play

import UIKit

class Player {
    var attacks = ["regAttack1", "regAttack2", "regAttack3","regAttack4"]
    var health = 100
    
    func attack()->(message: String, damage: Int) {
        let randomIndex = Int(arc4random_uniform(UInt32(attacks.count)))
        var message = attacks[randomIndex]
        var damage = 0
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
    var player1: Player
    var player2: Player
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    func playGame() {
        println("let the game begin!!")
    }
    
}

var player1 = Player()
player1.attacks

var goodplayer1 = GoodPlayer()
goodplayer1.attacks

player1.attack()
player1.attack()
player1.attack()
player1.attack()
player1.attack()

goodplayer1.attack()
goodplayer1.attack()
goodplayer1.attack()
goodplayer1.attack()
goodplayer1.attack()

var badplayer1 = BadPlayer()

badplayer1.attack()
badplayer1.attack()
badplayer1.attack()
badplayer1.attack()
badplayer1.attack()
badplayer1.attack()
badplayer1.attack()
badplayer1.attack()








