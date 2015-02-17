//
//  ViewController.swift
//  CalculatorMT
//
//  Created by Alexis Saint-Jean on 2/16/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // The numOfDigits variable makes sure that no more than 9 digits
    // are entered in (similar to the Apple calculator app)
    var numOfDigits = 0
    // The decimalAdded variable is a boolean to check whether 
    // the user already added decimals
    var decimalAdded = false
    // The signString variable is a string to include a negative sign
    // if the user wants the number to be negative and no sign (default) if the user wants the number to be positive
    var signString = ""
    
    @IBOutlet weak var numberField: UITextField!
    @IBAction func zeroButton(sender: AnyObject) {
        // if 0 is the first digit the user type, then do nothing
        if numOfDigits != 0 {
        enterDigits("0", increaseInDigits: 1)
        }
    }
    @IBAction func decimalButton(sender: AnyObject) {
        // If the user tap the decimal button as the first one
        if numOfDigits == 0 {enterDigits("0.", increaseInDigits: 1)
        } else if self.decimalAdded == false {
            self.decimalAdded = true
            enterDigits(".", increaseInDigits: 0)
        }
    }
    @IBAction func oneButton(sender: AnyObject) {
        enterDigits("1", increaseInDigits: 1)
    }
    @IBAction func twoButton(sender: AnyObject) {
        enterDigits("2", increaseInDigits: 1)
    }
    @IBAction func threeButton(sender: AnyObject) {
        enterDigits("3", increaseInDigits: 1)
    }
    @IBAction func plusButton(sender: AnyObject) {
    }
    @IBAction func fourButton(sender: AnyObject) {
        enterDigits("4", increaseInDigits: 1)
    }
    @IBAction func fiveButton(sender: AnyObject) {
        enterDigits("5", increaseInDigits: 1)
    }
    @IBAction func sixButton(sender: AnyObject) {
        enterDigits("6", increaseInDigits: 1)
    }
    @IBAction func minusButton(sender: AnyObject) {
    }
    @IBAction func sevenButton(sender: AnyObject) {
        enterDigits("7", increaseInDigits: 1)
    }
    @IBAction func eightButton(sender: AnyObject) {
        enterDigits("8", increaseInDigits: 1)
    }
    @IBAction func nineButton(sender: AnyObject) {
        enterDigits("9", increaseInDigits: 1)
    }
    @IBAction func multiplyButton(sender: AnyObject) {
    }
    @IBAction func clearButton(sender: AnyObject) {
        // Reset a bunch of variable to their initial state
        self.numOfDigits = 0
        self.numberField.text = "0"
        self.decimalAdded = false
        self.signString = ""
        println("reset everything to 0")
    }
    @IBAction func changeSignButton(sender: AnyObject) {
        if self.signString == "" {
            self.signString = "-"
        } else {
            self.signString = ""
        }
        enterDigits(self.signString, increaseInDigits: 0)
    }
    @IBAction func percentButton(sender: AnyObject) {
    }
    @IBAction func divideButton(sender: AnyObject) {
    }

    func enterDigits(digitToEnter: String, increaseInDigits: Int) {
        if digitToEnter == "-" {
            var currentNumField = self.numberField.text
            self.numberField.text = "-" + currentNumField
            println("minus sign")
        }
        else if digitToEnter == "" {
            var currentNumField = self.numberField.text
            self.numberField.text = currentNumField.substringWithRange(Range<String.Index>(start: advance(currentNumField.startIndex, 1), end: currentNumField.endIndex))
             println("plus sign")
        }
        else if self.numOfDigits < 9 {
            if self.numOfDigits == 0 {
            // for the first digit we wipe out the initial 0 on the screen and replace it with the digit entered by the user
            self.numOfDigits += 1
            self.numberField.text = self.signString + digitToEnter
                println("successfully entered first digit")}
            else {
                self.numOfDigits += increaseInDigits
                var previousNumField = self.numberField.text
                self.numberField.text = previousNumField + digitToEnter
                println("successfully entered following digit")}
        } else {
        println("didn't change anything because too many digits")
        }
    }

    func textFieldShouldBeginEditing(textField: UITextField)-> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.numberField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

