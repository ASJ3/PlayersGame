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
    
    @IBAction func mainFunction(sender: AnyObject) {
        
    }
    // Function that ensures the keyboard disappear after the player enters 'Return'
    // on the pop-up keyboard when they are done entering their name
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
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

