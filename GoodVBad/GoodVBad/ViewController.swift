//
//  ViewController.swift
//  GoodVBad
//
//  Created by Alexis Saint-Jean on 1/16/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var GoodPlayerName: UITextField!
    @IBOutlet weak var GoodPlayerSchool: UILabel!
    @IBOutlet weak var GoodPlayerHealth: UILabel!

    @IBOutlet weak var BadPlayerName: UILabel!
    @IBOutlet weak var BadPlayerSchool: UILabel!
    @IBOutlet weak var BadPlayerHealth: UILabel!

    @IBOutlet weak var MainText: UILabel!
    
    @IBOutlet weak var MainButton: UIButton!
    
//    @IBOutlet weak var firstButton: UIButton!
//    @IBOutlet weak var secondButton: UIButton!
//    @IBOutlet weak var thirdButton: UIButton!
//    @IBOutlet weak var fourthButton: UIButton!
    
    var player1 = Player(playerName: "")
    var player2 = Player(playerName: "")
    // readyToPlay is a var created to indicate whether a name has been entered by the player
    // It starts at 0 (player did not enter name in the textField so game is not ready to play
    // Then it changes to 1 (game is ready)
    var readyToPlay = 0
    
    @IBAction func MainAction(sender: AnyObject) {
        if readyToPlay == 1 {
            println("should change the text of different fields when button is pressed")
            player1 = GoodPlayer(playerName: GoodPlayerName.text)
            player2 = BadPlayer(playerName: "Draco")
            GoodPlayerSchool.text = player1.school
            BadPlayerName.text = player2.name
            BadPlayerSchool.text = player2.school
//            firstButton.setTitle(player1.attacks[0], forState: UIControlState.Normal)
//            secondButton.setTitle(player1.attacks[1], forState: UIControlState.Normal)
//            thirdButton.setTitle(player1.attacks[2], forState: UIControlState.Normal)
//            fourthButton.setTitle(player1.attacks[3], forState: UIControlState.Normal)
            
            MainText.text = "Let the game begin!"
            readyToPlay = 0
            
        } else {
            MainText.text = "Enter your name, then click on the 'Next' button below."
            GoodPlayerName.text = ""
            GoodPlayerName.placeholder = "Enter your name"
            GoodPlayerSchool.text = "School Name"
            BadPlayerName.text = "Player Name"
            BadPlayerSchool.text = "School Name"
            
//            firstButton.setTitle("First", forState: UIControlState.Normal)
//            secondButton.setTitle("Second", forState: UIControlState.Normal)
//            thirdButton.setTitle("Third", forState: UIControlState.Normal)
//            fourthButton.setTitle("Fourth", forState: UIControlState.Normal)
            
            println("All the fields should be reset to default")
            
        }
    }
    
    // Function that ensures the keyboard disappear after the player enters 'Return'
    // on the pop-up keyboard when they are done entering their name
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        readyToPlay = 1
        println("readyToPlay's value is now: \(readyToPlay)")
        return true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GoodPlayerName.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

