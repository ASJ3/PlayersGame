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
    // Two variables to store our values when we are calculating
    var firstNumber: Double = 0.0
    var SecondNumber: Double = 0.0
    
    var firstNumberEntered = false
    var secondNumbeEntered = false
    
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
            self.decimalAdded = true
        } else if self.decimalAdded == false && self.numOfDigits < 9 {
            self.decimalAdded = true
            enterDigits(".", increaseInDigits: 0)
        }
    }
    
    @IBAction func equalButton(sender: AnyObject) {
        turnTextToNumber(self.numberField.text)
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
        resetCalculator()
    }
    
    func resetCalculator() {
        // Reset a bunch of variables to their initial state
        self.numOfDigits = 0
        self.numberField.text = "0"
        self.decimalAdded = false
        self.signString = ""
        self.clearButtonText.setTitle("AC", forState: UIControlState.Normal)
        println("reset everything to 0")
    }
    
    @IBOutlet weak var clearButtonText: UIButton!
    // deleteRightDigit() is a function to delete the last digit, one at a time, and can go back to the default "0"
    @IBAction func deleteRightDigit(sender: AnyObject) {
        // creating variables to store the leftmost and rightmost digits in numField
        var currentNumField = self.numberField.text
        var rightMostDigit = currentNumField.substringWithRange(Range<String.Index>(start: advance(currentNumField.endIndex, -1), end: currentNumField.endIndex))
        var leftMostDigit = currentNumField.substringWithRange(Range<String.Index>(start: currentNumField.startIndex, end: advance(currentNumField.startIndex,1)))
        
        if self.numberField.text == "0." || self.numberField.text == "-0."{
            resetCalculator()
        } else if leftMostDigit == "-" && countElements(self.numberField.text) == 2{
            resetCalculator()
        } else if countElements(self.numberField.text) == 1 {
            resetCalculator()
        } else if rightMostDigit == "." {
            self.numberField.text = currentNumField.substringWithRange(Range<String.Index>(start: currentNumField.startIndex, end: advance(currentNumField.endIndex, -1)))
            self.decimalAdded = false
        } else {
            self.numberField.text = currentNumField.substringWithRange(Range<String.Index>(start: currentNumField.startIndex, end: advance(currentNumField.endIndex, -1)))
            self.numOfDigits -= 1
        }
        
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
        var percentNumber = turnTextToNumber(self.numberField.text) / 100
        println("current is now \(percentNumber)")
        self.decimalAdded = true
        var numberAsString = String(format:"%.9f", percentNumber)
        println("the number to display is \(numberAsString)")
        var finalResult = trimDecimals(numberAsString)
        self.numberField.text = finalResult
        
    }
    
    // The purpose of trimDecimals is to cut the numbers of "0" at the end of the number, so as to only show the number of decimals that are needed
    func trimDecimals(numAsText: String)->String {
        var rightEdgeOfNumberFound = false
        var arrayOfDigits = [String]()
        var resultingSring = "0"
        
        for i in numAsText {
            var digitAsString = String(i)
            arrayOfDigits.append(digitAsString)
        }
        println("array of Digits is now \(arrayOfDigits)")

        // now we will delete all the unneeded 0 in the decimal part
        for i in 1..<arrayOfDigits.count + 1 {
            print("i is now \(i). ")
            if arrayOfDigits[arrayOfDigits.count - i] == "0" && rightEdgeOfNumberFound == false {
                println("getting rid of 0")
            } else {
                println("found the right edge of the number")
                var copyOfArrayOfDigits = arrayOfDigits[0...arrayOfDigits.count - i]
                resultingSring = "".join(copyOfArrayOfDigits)
                println("foo is now \(copyOfArrayOfDigits)")
                break
            }
            
        }
        return resultingSring
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
            // Change the text of the clear button from AC to C just like in Apple's app
                self.clearButtonText.setTitle("C", forState: UIControlState.Normal)
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
    
    func turnTextToNumber(textToProcess: String)-> Double {
        var processedNumber = (textToProcess as NSString).doubleValue
        println("the processed Number is now: \(processedNumber)")
        return processedNumber
    }
    
    // textFieldShouldBeginEditing function returning false is only because we are using a textField to display our text (free text resizing ability)
    // but we don't want a keyboard to display when clicking on the textField
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

