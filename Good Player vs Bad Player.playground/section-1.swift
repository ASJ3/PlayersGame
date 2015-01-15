// Playground - noun: a place where people can play

import UIKit

/* 
***************************
Note: try to make the game class in such a way that the first player to play is random

Also need to fix the playMatch function so that the loop ends if the second player's health went to 0 or under after the first player's attack

Get a name property for the player class

***************************
*/

class Player {
    var attacks = ["regAttack1", "regAttack2", "regAttack3","regAttack4"]
    var health = 100
    
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
        // Reset the health of each player to 100 in case we are playing
        // multiple consecutive games
        player1.health = 100
        player2.health = 100
        
        // This while loop will keep going as long as both player's health is above 0, which is checked by using the isAlive method for each player
        // While the loop is valid each player will take turn and attack its opponent
        // each attack will reduce the health of the opponent by a random number between 5 and 20, so the minimum number of rounds should be 5
        while player1.isAlive() && player2.isAlive() {
        var player1Attack = player1.attack()
        player2.health -= player1Attack.damage
        println("Player 1 used: \(player1Attack.message), with a damage of \(player1Attack.damage)")
        var player2Attack = player2.attack()
        player1.health -= player2Attack.damage
        println("Player 2 used: \(player2Attack.message), with a damage of \(player2Attack.damage)")
        }
        
        println("Game ended! Player 1 health is: \(player1.health). Player 2 health is: \(player2.health)")
        
        
    }
    
}

var player1 = Player()
player1.attacks
player1.attack()

var goodplayer1 = GoodPlayer()
goodplayer1.attacks
goodplayer1.attack()


var badplayer1 = BadPlayer()
badplayer1.attacks
badplayer1.attack()

var newMatch = Match(player1: goodplayer1, player2: badplayer1)

newMatch.playGame()
newMatch.playGame()
newMatch.playGame()












