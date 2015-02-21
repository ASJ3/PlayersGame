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
    // The numOfIntegers variable indicates the number of integers making our number (this will help us place the "," separator for thousands
    var numOfIntegers = 1
    // the numberArray stores all the keystrokes making the number
    var numberArray = ["0"]
    // The decimalAdded variable is a boolean to check whether 
    // the user already added decimals
    var decimalAdded = false
    // The signString variable is a string to include a negative sign
    // if the user wants the number to be negative and no sign (default) if the user wants the number to be positive
    var signString = ""
    // Two variables to store our values when we are calculating
    var firstNumber: Double = 0.0
    var secondNumber: Double = 0.0
    
    var firstNumberEntered = false
    var secondNumberEntered = false
    var startingOtherNumber = false
    
    var calcOperation = ""
    
    @IBOutlet weak var numberField: UITextField!
    @IBAction func zeroButton(sender: AnyObject) {
        // if the user types 0 at first, do nothing, else enter "0"
        if numOfDigits != 0 {
        enterDigits("0", increaseInDigits: 1)
        }
    }
    @IBAction func decimalButton(sender: AnyObject) {
        // If the user tap the decimal button at first
        if numOfDigits == 0 {
            enterDigits("0", increaseInDigits: 1)
            enterDigits(".", increaseInDigits: 0)
            self.decimalAdded = true
        } else if self.decimalAdded == false && self.numOfDigits < 9 {
            self.decimalAdded = true
            enterDigits(".", increaseInDigits: 0)
        }
    }
    
    
    
    @IBAction func equalButton(sender: AnyObject) {
//        turnTextToNumber(self.numberField.text)
        
        var numAsString = "".join(self.numberArray)
        self.secondNumber = (numAsString as NSString).doubleValue
        self.secondNumberEntered = true
        println("the number is \(self.firstNumber)")
        var resultNumber = self.firstNumber + self.secondNumber
        var resultString = String(format:"%.10f", resultNumber)
        var trimmedStringNumber = trimDecimals(resultString)
        var arrayCopy = Array(trimmedStringNumber)
        self.numberArray = []
        for i in arrayCopy {
            self.numberArray.append(String(i))
        }
//        self.numberArray = Array(arrayLiteral: trimmedStringNumber)
        formatDisplay()
//        resetCalculator()
        
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
        var numAsString = "".join(self.numberArray)
        self.firstNumber = (numAsString as NSString).doubleValue
        self.firstNumberEntered = true
        self.startingOtherNumber = true
        println("the number is \(self.firstNumber)")
        self.calcOperation = "+"
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
        self.numOfIntegers = 1
        self.decimalAdded = false
        self.signString = ""
        self.numberArray = ["0"]
        self.clearButtonText.setTitle("AC", forState: UIControlState.Normal)
        println("reset everything to 0")
    }
    
    // Made an outlet for the clear button so we could change its text from "AC" to "C" and vice versa
    @IBOutlet weak var clearButtonText: UIButton!
    
    // deleteRightDigit() is a function to delete the last digit, one at a time, and can go back to the default "0"
    @IBAction func deleteRightDigit(sender: AnyObject) {

        //*********
        var lastElement = self.numberArray.last!
        if lastElement == "." {
            self.decimalAdded = false
        } else if self.decimalAdded == false {
            self.numOfIntegers -= 1
            self.numOfDigits -= 1
        } else {
            self.numOfDigits -= 1
        }
        self.numberArray.removeAtIndex(self.numberArray.count - 1)
        if self.numberArray.isEmpty || self.numberArray == ["-"] {
            resetCalculator()
        }
        println("the number array is: \(self.numberArray)")
        formatDisplay()
//        self.numberField.text = "".join(self.numberArray)
        //END *************
        
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
//        var percentNumber = turnTextToNumber(self.numberField.text) / 100
//        println("current is now \(percentNumber)")
//        self.decimalAdded = true
//        var numberAsString = String(format:"%.9f", percentNumber)
//        println("the number to display is \(numberAsString)")
//        var finalResult = trimDecimals(numberAsString)
//        self.numberField.text = finalResult
        
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
        // If a first number has been entered and then a calculation sign pushed
        // then the startingOtherNumber becomes true.
        // Then as soon as we start typing the second number, we reset the display to "0" and we put back startingOtherNumber to false
        if self.startingOtherNumber == true {
            self.startingOtherNumber = false
            resetCalculator()
        }
        
        if digitToEnter == "-" {
//            var currentNumField = self.numberField.text
//            self.numberField.text = "-" + currentNumField
            
            //*************
            self.numberArray.insert("-", atIndex: 0)
            println("minus sign")
            println(self.numberArray)
        }
        else if digitToEnter == "" {

            //*************
            self.numberArray.removeAtIndex(0)
            println("plus sign")
            println(self.numberArray)
            formatDisplay()
        }
        else if self.numOfDigits < 9 {
            if self.numOfDigits == 0 {
                
            // Change the text of the clear button from AC to C just like in Apple's app
                self.clearButtonText.setTitle("C", forState: UIControlState.Normal)
                
                //*************
                if self.signString == "-" {
                    self.numberArray[1] = digitToEnter
                } else {
                    self.numberArray[0] = digitToEnter
                }
                self.numOfIntegers = 1
                self.numOfDigits += 1
                println(self.numberArray)
                println("successfully entered first digit")
                //END *************
            }
            else {
                
                //*************
                self.numberArray.append(digitToEnter)
                if decimalAdded == false {
                    self.numOfIntegers += 1
                }
                self.numOfDigits += increaseInDigits
                println(self.numberArray)
                //END *************
                
                println("Entered digit \(self.numOfDigits)")}
        } else {
        println("Already \(self.numOfDigits) digits")
        }
        self.numberField.text = "".join(self.numberArray)
        formatDisplay()
        println("after format display")
    }
    
    // formatDisplay() main goal is to add "," separator for thousands
    func formatDisplay() {
        println("\n*******\nStart of formatDisplay()")
        var signRemoved  = false
        var arrayCopy = self.numberArray
        println("arrayCopy is now \(arrayCopy)")
        
        if self.signString == "-" {
            signRemoved = true
            arrayCopy.removeAtIndex(0)
             println("arrayCopy had minus sign removed \(arrayCopy)")
        }
        
        if self.numOfIntegers > 3 {
            
            // figure out the number of "," separators we need to add
            var separators = (self.numOfIntegers-1) / 3

            println("format display: number of separators \(separators)")
            
            if separators == 1 {
                arrayCopy.insert(",", atIndex: (self.numOfIntegers - 3))
            } else if separators == 2 {
                arrayCopy.insert(",", atIndex: (self.numOfIntegers - 3))
                arrayCopy.insert(",", atIndex: (self.numOfIntegers - 6))
            }
        }
        
        if signRemoved == true {
            arrayCopy.insert("-", atIndex: 0)
            println("arrayCopy had minus sign re-added \(arrayCopy)")
        }
        println(arrayCopy)
        println(self.numberArray)
        self.numberField.text = "".join(arrayCopy)
    }
    
    
//    func turnTextToNumber(textToProcess: String)-> Double {
//        var processedNumber = (textToProcess as NSString).doubleValue
//        println("the processed Number is now: \(processedNumber)")
//        return processedNumber
//    }
    
    
    
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
        // Dispose of any resources that can be recreated.
    }

}

