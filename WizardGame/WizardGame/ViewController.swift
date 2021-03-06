//
//  ViewController.swift
//  WizardGame
//
//  Created by Alexis Saint-Jean on 1/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    // The receivedName variable will hold the player name entered in the previous view controller
    var receivedName = ""
    
    @IBOutlet weak var humanPlayerSchoolPic: UIImageView!
    @IBOutlet weak var humanPlayerName: UITextField!
    @IBOutlet weak var humanPlayerSchool: UILabel!
    @IBOutlet weak var humanPlayerHealth: UILabel!
    

    @IBOutlet weak var computerPlayerSchoolPic: UIImageView!
    @IBOutlet weak var computerPlayerName: UILabel!
    @IBOutlet weak var computerPlayerSchool: UILabel!
    @IBOutlet weak var computerPlayerHealth: UILabel!
    @IBOutlet weak var mainLabel: UITextView!
    
    @IBOutlet weak var topLeft: UIButton!
    @IBOutlet weak var topRight: UIButton!
    @IBOutlet weak var bottomLeft: UIButton!
    @IBOutlet weak var bottomRight: UIButton!
    
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
    // Then it changes to 1 (game is being set up)
    var readyToPlay = 0
    
    @IBAction func mainFunction(sender: AnyObject) {
        // readyToPlay at 1 is to set up a new game
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
            newMatch = Match(player1: self.player1, player2: self.player2)
            
            mainLabel.text = "Let the game begin!\n\(player1.name) from \(player1.school) will play against \(player2.name) from \(player2.school)"
            // Changing readyToPlay to 2 ('game is started')
            readyToPlay = 2
            // Changing playerTurn to 1 ('1st player to play')
            playerTurn = 1
            
            // Changing the name of the buttons to the name of each attack possible
            topLeft.setTitle(player1.attacks[0], forState: .Normal)
            topRight.setTitle(player1.attacks[1], forState: .Normal)
            bottomLeft.setTitle(player1.attacks[2], forState: .Normal)
            bottomRight.setTitle(player1.attacks[3], forState: .Normal)
            
            println("readyToPlay has been changed to: \(readyToPlay)")
           
        // the following loop where readyToPlay = 2 alterns between both players casting spell at each other (i.e playerTurn = 1 or 2)
        } else if readyToPlay == 2 {

            if playerTurn == 1 && player1.isAlive() {
                var attackResults = newMatch.attackRound(attackingPlayer: player1, defendingPlayer: player2)
                
                player2.health = attackResults.attackDamage
                computerPlayerHealth.text = String(player2.health)
                
                mainLabel.text = attackResults.attackMessage
                
                // Indicates that it is the second player's turn to play on the next round
                playerTurn = 2
                
            } else if playerTurn == 2 && player2.isAlive() {
                var attackResults = newMatch.attackRound(attackingPlayer: player2, defendingPlayer: player1)

                player1.health = attackResults.attackDamage
                humanPlayerHealth.text = String(player1.health)
                
                mainLabel.text = attackResults.attackMessage
                
                // Indicates that it is the first player's turn to play on the next round
                playerTurn = 1
            } else if !player1.isAlive() {
                mainLabel.text = "\(player2.name) won!"
                readyToPlay = 0
                
            } else if !player2.isAlive() {
                mainLabel.text = "\(player1.name) won!"
                readyToPlay = 0
                
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
            
            // Changing the name of the buttons back to the default
            topLeft.setTitle("button", forState: .Normal)
            topRight.setTitle("button", forState: .Normal)
            bottomLeft.setTitle("button", forState: .Normal)
            bottomRight.setTitle("button", forState: .Normal)
            
            
            
        }
        
    }
    // Function that ensures the keyboard disappear after the player enters 'Return'
    // on the pop-up keyboard when they are done entering their name
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        // After the player has entered a name, the game is now ready to play
        // so the readyToPlay variable is changed to 1
        readyToPlay = 1
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.humanPlayerName.delegate = self;
        var newMatch = Match(player1: Player(playerName: ""), player2: Player(playerName: ""))
        // Adding rounded corners to the textfield and two pictures
        mainLabel.layer.cornerRadius = 4
        humanPlayerSchoolPic.layer.cornerRadius = 2
        humanPlayerSchoolPic.clipsToBounds = true
        
        computerPlayerSchoolPic.layer.cornerRadius = 2
        computerPlayerSchoolPic.clipsToBounds = true
        
        // Setting up the name of the human player to the string received from the first view controller
        humanPlayerName.text = receivedName
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

