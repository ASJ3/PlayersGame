//
//  ViewController.swift
//  CalculatorMT
//
//  Created by Alexis Saint-Jean on 2/16/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // The decimalAdded variable is a boolean to check whether
    // the user already added decimals
    var decimalAdded = false
    
    var numberOfKeystrokes = 0
    
    var currentCalcNumber = CalcNumber()
    var firstCalcNumber = CalcNumber()
    var secondCalcNumber = CalcNumber()
    
    var operationNumbers = [CalcNumber]()
    
    var firstNumberEntered = false
    var secondNumberEntered = false
    var startingOtherNumber = false
    
    var calcOperation = ""
    
    @IBOutlet weak var numberField: UITextField!
    
    // Number buttons
    @IBAction func zeroButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("0")
        calcDisplayManager("number")
            }
    @IBAction func oneButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("1")
        calcDisplayManager("number")
    }
    @IBAction func twoButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("2")
        calcDisplayManager("number")
    }
    @IBAction func threeButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("3")
        calcDisplayManager("number")
    }
    @IBAction func fourButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("4")
        calcDisplayManager("number")
    }
    @IBAction func fiveButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("5")
        calcDisplayManager("number")
    }
    @IBAction func sixButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("6")
        calcDisplayManager("number")
    }
    @IBAction func sevenButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("7")
        calcDisplayManager("number")
    }
    @IBAction func eightButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("8")
        calcDisplayManager("number")
    }
    @IBAction func nineButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("9")
        calcDisplayManager("number")
    }
    
    // Sign and decimal buttons
    @IBAction func changeSignButton(sender: AnyObject) {
        self.currentCalcNumber.changeSign()
        calcDisplayManager("number")
    }
    @IBAction func decimalButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit(".")
        calcDisplayManager("number")
    }
    
    
    @IBAction func percentButton(sender: AnyObject) {
    }
    
    @IBAction func equalButton(sender: AnyObject) {
    }
    
    @IBAction func plusButton(sender: AnyObject) {
        self.calcOperation = "+"
        calcDisplayManager("operation")
    }

    @IBAction func minusButton(sender: AnyObject) {
    }
    
    @IBAction func multiplyButton(sender: AnyObject) {
    }
    
    @IBAction func divideButton(sender: AnyObject) {
    }
    

    
    @IBAction func clearButton(sender: AnyObject) {
        calcDisplayManager("clear")
    }
    
    func calcDisplayManager(Keystroke: String) {
        if Keystroke == "number" {
            self.numberOfKeystrokes += 1
        }
        else if Keystroke == "operation" {
            self.operationNumbers.append(self.currentCalcNumber)
            println("calcDisplayManager(): the operationsNumber array is \(self.operationNumbers[0].arrayNumber)")
            self.currentCalcNumber = CalcNumber()
            self.numberOfKeystrokes = 0
            self.firstNumberEntered = true
        }
        else if Keystroke == "clear" {
            if self.operationNumbers.count == 1 && self.firstNumberEntered == true {
                self.firstNumberEntered = false
                self.currentCalcNumber = CalcNumber()
                println("calcDisplayManager(): resetting the second number to 0. The first number is still stored and \(self.operationNumbers[0].arrayNumber)")
                
            } else if self.operationNumbers.count == 1 && self.firstNumberEntered == false {
                self.operationNumbers = []
                println("calcDisplayManager(): resetting the first number to 0. The operationsNumber array has a count of \(self.operationNumbers.count)")
            }
            self.currentCalcNumber = CalcNumber()
            self.numberOfKeystrokes = 0
        }
        
        if self.numberOfKeystrokes > 0 {
            self.clearButtonText.setTitle("C", forState: .Normal)
        } else {
            self.clearButtonText.setTitle("AC", forState: .Normal)
        }

        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    
    // Made an outlet for the clear button so we could change its text from "AC" to "C" and vice versa
    @IBOutlet weak var clearButtonText: UIButton!
    
    // deleteRightDigit() is a function to delete the last digit, one at a time, and can go back to the default "0"
    @IBAction func deleteRightDigit(sender: AnyObject) {
    }
    

    
    // The purpose of trimDecimals is to cut the numbers of "0" at the end of the number, so as to only show the number of decimals that are needed
    func trimDecimals(numAsText: String)->String {
        return "hello"
    }
    

    // textFieldShouldBeginEditing function returning false is only because we are using a textField to display our text (free text resizing ability)
    // but we don't want a keyboard to display when clicking on the textField
    func textFieldShouldBeginEditing(textField: UITextField)-> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

