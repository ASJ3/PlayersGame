//
//  ViewController.swift
//  TimingProject
//
//  Created by Alexis Saint-Jean on 1/29/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var goalNameField: UITextField!
    @IBOutlet weak var goalHoursField: UITextField!
    @IBOutlet weak var goalMinutesField: UITextField!
    @IBOutlet weak var goalDaysField: UITextField!

    
    // Function that ensures the keyboard disappear after the player enters 'Return'
    // on the pop-up keyboard when they are done entering their name
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Add self as the delegate to a bunch of textfields
        // to make sure the keyboard disappear when entering "Return"
        self.goalNameField.delegate = self
        self.goalHoursField.delegate = self
        self.goalMinutesField.delegate = self
        self.goalDaysField.delegate = self
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

