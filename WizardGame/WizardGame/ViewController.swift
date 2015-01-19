//
//  ViewController.swift
//  WizardGame
//
//  Created by Alexis Saint-Jean on 1/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var humanPlayerName: UITextField!
    @IBOutlet weak var humanPlayerSchool: UILabel!
    @IBOutlet weak var humanPlayerHealth: UILabel!
    

    @IBOutlet weak var computerPlayerName: UILabel!
    @IBOutlet weak var computerPlayerSchool: UILabel!
    @IBOutlet weak var computerPlayerHealth: UILabel!
    @IBOutlet weak var mainLabel: UITextView!
    
    // Creating 5 global variables
    var player1 = Player(playerName: "")
    var player2 = Player(playerName: "")
    // playerTurn is a variable that indicates what player is currently playing
    var playerTurn = 0
    
    // *****************************************
    // For some reason I can't instantiate Match() by using the player1 and player2
    // variables as properties
    // If I do I get an error message saying ViewController.Type does not have a member named...
    var newMatch = Match(player1: Player(playerName: ""), player2: Player(playerName: ""))
    
    // readyToPlay is a var created to indicate whether a name has been entered by the player
    // It starts at 0 (player did not enter name in the textField so game is not ready to play
    // Then it changes to 1 (game is ready)
    var readyToPlay = 0
    
    @IBAction func mainFunction(sender: AnyObject) {
        
        if readyToPlay == 1 {
            println("readyToPlay is now: \(readyToPlay)")
            
            player1 = GoodPlayer(playerName: humanPlayerName.text)
            player2 = BadPlayer(playerName: "Draco")
            
            humanPlayerSchool.text = player1.school
            humanPlayerHealth.text = String(player1.health)
            
            computerPlayerName.text = player2.name
            computerPlayerSchool.text = player2.school
            computerPlayerHealth.text = String(player2.health)
            
            // We're now starting a new match with player1 against player2
            newMatch = Match(player1: player1, player2: player2)
            
            mainLabel.text = "Let the game begin!\n\(player1.name) from \(player1.school) will play against \(player2.name) from \(player2.school)"
            // Changing readyToPlay to 2 ('game is started')
            readyToPlay = 2
            // Changing playerTurn to 1 ('1st player to play')
            playerTurn = 1
            
            println("readyToPlay has been changed to: \(readyToPlay)")
            
        } else if readyToPlay == 2 {

            if playerTurn == 1 {
                var attackResults = newMatch.attackRound(attackingPlayer: player1, defendingPlayer: player2)
                
                player2.health = attackResults.attackDamage
                computerPlayerHealth.text = String(player2.health)
                
                mainLabel.text = attackResults.attackMessage
                
                // Indicates that it is the second player's turn to play on the next round
                playerTurn = 2
                
            } else {
                var attackResults = newMatch.attackRound(attackingPlayer: player2, defendingPlayer: player1)

                player1.health = attackResults.attackDamage
                humanPlayerHealth.text = String(player1.health)
                
                mainLabel.text = attackResults.attackMessage
                
                // Indicates that it is the first player's turn to play on the next round
                playerTurn = 1
            }
            
            
            
        } else {
            println("readyToPlay is now: \(readyToPlay)")
            
            humanPlayerName.text = ""
            humanPlayerName.placeholder = "Enter your name"
            humanPlayerSchool.text = "School"
            humanPlayerHealth.text = "0"
            computerPlayerName.text = "Name"
            computerPlayerSchool.text = "School"
            computerPlayerHealth.text = "0"
            
            mainLabel.text = "Enter your name, then click on 'Next'"
            
            
            
        }
        
    }
    // Function that ensures the keyboard disappear after the player enters 'Return'
    // on the pop-up keyboard when they are done entering their name
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        readyToPlay = 1
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.humanPlayerName.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

