//
//  Match.swift
//  WizardGame
//
//  Created by Alexis Saint-Jean on 1/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import Foundation

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
        
        startingPlayer = self.player1
        followingPlayer = self.player2
        
//        if randomFirst == 1 {
//            startingPlayer = self.player1
//            followingPlayer = self.player2
//        } else {
//            startingPlayer = self.player2
//            followingPlayer = self.player1
//        }
        
        println("Let the game begin!! \(startingPlayer.name) will start. \(followingPlayer.name) will play second.")
        // Reset the health of each player to 100 in case we are playing
        // multiple consecutive games
        startingPlayer.health = 100
        followingPlayer.health = 100
        
        // This while loop will keep going as long as both players' health is above 0, which is checked by using the isAlive method for each player
        // While the loop is valid each player will take turn and attack its opponent
        // each attack will reduce the health of the opponent by a random number between 5 and 20, so the minimum number of rounds should be 5
//        while startingPlayer.isAlive() && followingPlayer.isAlive() {
        
//            attackRound(attackingPlayer: startingPlayer, defendingPlayer: followingPlayer)
        
//            var startingPlayerAttack = startingPlayer.attack()
//            followingPlayer.health -= startingPlayerAttack.damage
//            println("1. \(startingPlayer.name) used: \(startingPlayerAttack.message) (-\(startingPlayerAttack.damage) pts)")
            // After the attack of the first player checks whether the second player has enough health to launch an attack
//            if !followingPlayer.isAlive() {
//                break
//            }
        
//            attackRound(attackingPlayer: followingPlayer, defendingPlayer: startingPlayer)
//            var followingPlayerAttack = followingPlayer.attack()
//            startingPlayer.health -= followingPlayerAttack.damage
//            println("2. \(followingPlayer.name) used: \(followingPlayerAttack.message) (-\(followingPlayerAttack.damage) pts)")
//        }
        
//        if startingPlayer.isAlive() {
//            println("\(startingPlayer.name) wins!! \(startingPlayer.name)'s health is \(startingPlayer.health), whereas \(followingPlayer.name)'s health is \(followingPlayer.health)")
//        } else {
//            println("\(followingPlayer.name) wins!! \(followingPlayer.name)'s health is \(followingPlayer.health), whereas \(startingPlayer.name)'s health is \(startingPlayer.health)")
//        }
//        println(" ")
        
    }
    
    func attackRound (#attackingPlayer: Player, defendingPlayer: Player)->(attackMessage:String, attackDamage: Int) {
        var playerAttack = attackingPlayer.attack()
        
        return ("\(attackingPlayer.name) used:\n\(playerAttack.message) (-\(playerAttack.damage) pts)", defendingPlayer.health - playerAttack.damage)
    }
    
}
