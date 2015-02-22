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
    
    var numberOfKeystrokes = 0
    
    var currentCalcNumber = CalcNumber()
    
    var firstCalcNumber = CalcNumber()
    var secondCalcNumber = CalcNumber()
    
    var firstNumberEntered = false
    var secondNumberEntered = false
    var startingOtherNumber = false
    
    var calcOperation = ""
    
    @IBOutlet weak var numberField: UITextField!
    @IBAction func zeroButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("0")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func decimalButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit(".")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    
    
    
    @IBAction func equalButton(sender: AnyObject) {
        var numAsString = "".join(self.numberArray)
        self.secondNumber = (numAsString as NSString).doubleValue
        self.secondNumberEntered = true
        println("==========\nequalButton(): the first number is \(self.firstNumber). The second number is \(self.secondNumber)")
        var resultNumber = self.firstNumber + self.secondNumber
        var resultString = String(format:"%.10f", resultNumber)

        var trimmedStringNumber = trimDecimals(resultString)
        println("equalButton(): the trimmedStringNumber is \(trimmedStringNumber)")
        var arrayCopy = Array(trimmedStringNumber)
        self.numberArray = []
        for i in arrayCopy {
            self.numberArray.append(String(i))
        }
//        formatDisplay()
//        resetCalculator()
        self.firstNumberEntered = true
        self.secondNumberEntered = false
        self.secondNumber = 0.0
        self.firstNumber = ("".join(self.numberArray) as NSString).doubleValue
        self.clearButtonText.setTitle("C", forState: .Normal)
        self.numOfDigits = 0
        self.numOfIntegers = 1
        self.decimalAdded = false
        self.signString = ""
        self.numberArray = ["0"]
        println("equalButton(): first number is \(self.firstNumber)")
        println("equalButton(): second number is \(self.secondNumber)")
        println("the number of digits is \(self.numOfDigits)")
        println("the number of integers is \(self.numOfIntegers)")
        
    }
    
    
    
    
    
    @IBAction func oneButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("1")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func twoButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("2")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func threeButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("3")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
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
        self.currentCalcNumber.addDigit("4")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func fiveButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("5")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func sixButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("6")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func minusButton(sender: AnyObject) {
    }
    @IBAction func sevenButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("7")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func eightButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("8")
        clearButtonManager("number")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func nineButton(sender: AnyObject) {
        self.currentCalcNumber.addDigit("9")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    @IBAction func multiplyButton(sender: AnyObject) {
        if self.clearButtonText.titleLabel!.text == "AC" {
            println("button is AC")
        } else if self.clearButtonText.titleLabel!.text == "C" {
            println("button is C")
        } else {
            println("What is going on??")
        }
    }
    @IBAction func clearButton(sender: AnyObject) {
        if  self.firstNumberEntered == true && self.clearButtonText.titleLabel!.text == "AC" {
            self.firstNumberEntered = false
            self.firstCalcNumber = CalcNumber()
            println("resetting the firstCalcNumber")
        }
        if self.firstNumberEntered == true {
            self.clearButtonText.setTitle("AC", forState: .Normal)
            self.currentCalcNumber = CalcNumber()
            println("resetting the currentCalcNumber")
        }
        println("something happening here?")
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
        clearButtonManager("clear")
        
//        resetCalculator()
//        println("clearButton: first number is \(self.firstNumber)")
//        println("second number is \(self.secondNumber)")
        
    }
    
    func clearButtonManager(Keystroke: String) {
        if Keystroke == "number" {
            self.numberOfKeystrokes += 1
        }
        if self.numberOfKeystrokes > 0 {
            self.clearButtonText.setTitle("C", forState: .Normal)
        } else {
            self.clearButtonText.setTitle("AC", forState: .Normal)
        }

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
        println("----------\nresetCalculator(): reset a lot of variables to their default values")
    }
    
    // Made an outlet for the clear button so we could change its text from "AC" to "C" and vice versa
    @IBOutlet weak var clearButtonText: UIButton!
    
    // deleteRightDigit() is a function to delete the last digit, one at a time, and can go back to the default "0"
    @IBAction func deleteRightDigit(sender: AnyObject) {

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
//        formatDisplay()
        
    }
    
    @IBAction func changeSignButton(sender: AnyObject) {

        self.currentCalcNumber.changeSign()
        self.numberField.text = self.currentCalcNumber.turnIntoFormattedString()
    }
    
    @IBAction func percentButton(sender: AnyObject) {
        
    }
    
    // The purpose of trimDecimals is to cut the numbers of "0" at the end of the number, so as to only show the number of decimals that are needed
    func trimDecimals(numAsText: String)->String {
//        var rightEdgeOfNumberFound = false
//        var arrayOfDigits = [String]()
//        var resultingSring = "0"
//        
//        for i in numAsText {
//            var digitAsString = String(i)
//            arrayOfDigits.append(digitAsString)
//        }
//        println("array of Digits is now \(arrayOfDigits)")
//
//        // now we will delete all the unneeded 0 in the decimal part
//        for i in 1..<arrayOfDigits.count + 1 {
////            print("i is now \(i). ")
//            if arrayOfDigits[arrayOfDigits.count - i] == "0" && rightEdgeOfNumberFound == false {
////                println("getting rid of 0")
//            } else if arrayOfDigits[arrayOfDigits.count - i] == "." {
//                println("trimDecimals(): found the decimal point and the right edge of the number. ")
//                var copyOfArrayOfDigits = arrayOfDigits[0...arrayOfDigits.count - i - 1]
//                resultingSring = "".join(copyOfArrayOfDigits)
//                self.decimalAdded = false
//                println("resultingSring is now \(copyOfArrayOfDigits)")
//                break
//            }else {
//                println("trimDecimals(): found the right edge of the number. ")
//                var copyOfArrayOfDigits = arrayOfDigits[0...arrayOfDigits.count - i]
//                resultingSring = "".join(copyOfArrayOfDigits)
//                println("resultingSring is now \(copyOfArrayOfDigits)")
//                break
//            }
//        }
//        return resultingSring
        return "hello"
    }
    
    @IBAction func divideButton(sender: AnyObject) {
    }


    // textFieldShouldBeginEditing function returning false is only because we are using a textField to display our text (free text resizing ability)
    // but we don't want a keyboard to display when clicking on the textField
    func textFieldShouldBeginEditing(textField: UITextField)-> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberField.delegate = self
        
        var newString = firstCalcNumber.turnIntoFormattedString()
        println("newString is now \(newString)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

