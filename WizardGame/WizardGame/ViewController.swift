//
//  ViewController.swift
//  WizardGame
//
//  Created by Alexis Saint-Jean on 1/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var goodPlayerSchool: UILabel!
    @IBOutlet weak var goodPlayerHealth: UILabel!
    
    @IBOutlet weak var badPlayerName: UILabel!
    @IBOutlet weak var badPlayerSchool: UILabel!
    @IBOutlet weak var badPlayerHealth: UILabel!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    var player1 = Player(playerName: "")
    var player2 = Player(playerName: "")
    // readyToPlay is a var created to indicate whether a name has been entered by the player
    // It starts at 0 (player did not enter name in the textField so game is not ready to play
    // Then it changes to 1 (game is ready)
    var readyToPlay = 0
    
    @IBAction func mainFunction(sender: AnyObject) {
        
        if readyToPlay == 1 {
            println("readyToPlay is now: \(readyToPlay)")
            
            player1 = GoodPlayer(playerName: playerName.text)
            player2 = BadPlayer(playerName: "Draco")
            
            goodPlayerSchool.text = player1.school
            badPlayerName.text = player2.name
            badPlayerSchool.text = player2.school
            
            readyToPlay = 0
            println("readyToPlay has been changed to: \(readyToPlay)")
            
        } else {
            println("readyToPlay is now: \(readyToPlay)")
            
            playerName.text = ""
            playerName.placeholder = "Enter your name"
            goodPlayerSchool.text = "School"
            badPlayerName.text = "Name"
            badPlayerSchool.text = "School"
            
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
        self.playerName.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

