// Playground - noun: a place where people can play

import UIKit


class Player {
    // The name of the various attacks is listed  in an array
    var attacks = ["regAttack1", "regAttack2", "regAttack3","regAttack4"]
    var health = 100
    var name = ""
    
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

class GoodPlayer: Player {
    var goodAttacks = ["goodAttack1", "goodAttack2", "goodAttack3"]
    
    
    override init(playerName: String) {
        super.init(playerName: playerName)
        attacks += goodAttacks
    }
    
    
}

class BadPlayer: Player {
    var badAttacks = ["badAttack1", "badAttack2", "badAttack3"]
    
    override init(playerName: String) {
        super.init(playerName: playerName)
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
        var randomFirst = Int(arc4random_uniform(2))+1
        var startingPlayer: Player
        var followingPlayer: Player
        
        if randomFirst == 1 {
            startingPlayer = self.player1
            followingPlayer = self.player2
        } else {
            startingPlayer = self.player2
            followingPlayer = self.player1
        }
        
        println("Let the game begin!! \(startingPlayer.name) will start. \(followingPlayer.name) will play second.")
        // Reset the health of each player to 100 in case we are playing
        // multiple consecutive games
        startingPlayer.health = 100
        followingPlayer.health = 100
        
        // This while loop will keep going as long as both players' health is above 0, which is checked by using the isAlive method for each player
        // While the loop is valid each player will take turn and attack its opponent
        // each attack will reduce the health of the opponent by a random number between 5 and 20, so the minimum number of rounds should be 5
        while startingPlayer.isAlive() && followingPlayer.isAlive() {
            
            var startingPlayerAttack = startingPlayer.attack()
            followingPlayer.health -= startingPlayerAttack.damage
            println("1. \(startingPlayer.name) used: \(startingPlayerAttack.message) (-\(startingPlayerAttack.damage) pts)")
        // After the attack of the first player checks whether the second player has enough health to launch an attack
            if !followingPlayer.isAlive() {
                break
            }
            
            var followingPlayerAttack = followingPlayer.attack()
            startingPlayer.health -= followingPlayerAttack.damage
            println("2. \(followingPlayer.name) used: \(followingPlayerAttack.message) (-\(followingPlayerAttack.damage) pts)")
        }
        
        if startingPlayer.isAlive() {
            println("\(startingPlayer.name) wins!! \(startingPlayer.name)'s health is \(startingPlayer.health), whereas \(followingPlayer.name)'s health is \(followingPlayer.health)")
        } else {
            println("\(followingPlayer.name) wins!! \(followingPlayer.name)'s health is \(followingPlayer.health), whereas \(startingPlayer.name)'s health is \(startingPlayer.health)")
        }
        println(" ")
        
        
    }
    
}

var player1 = Player(playerName: "Alexis")
player1.attacks
player1.attack()

var goodplayer1 = GoodPlayer(playerName: "Aurelien")
goodplayer1.attacks
goodplayer1.attack()


var badplayer1 = BadPlayer(playerName: "Tim")
badplayer1.attacks
badplayer1.attack()

var newMatch = Match(player1: goodplayer1, player2: badplayer1)

newMatch.playGame()
newMatch.playGame()
newMatch.playGame()
newMatch.playGame()
newMatch.playGame()
newMatch.playGame()


















