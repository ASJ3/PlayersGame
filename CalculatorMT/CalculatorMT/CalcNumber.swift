//
//  CalcNumber.swift
//  CalculatorMT
//
//  Created by Alexis Saint-Jean on 2/21/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import Foundation

class CalcNumber {
    var arrayNumber = ["0"]
    var arraySign = [""]
    var doubleNumber: Double?
    var stringNumber = ""
    var negativeNumber = false
    var decimalAdded = false
    
    init() {
        
    }
    
    func initWithDouble(Number: Double) {
        println("**** starting initWithDouble")
        var processedNumber = Number
        var processedString = ""
        self.arrayNumber = []
        var arrayCopy = [String]()
        if Number < 0 {
            changeSign()
            processedNumber *= -1
        }
        processedString = String(format:"%.9f", processedNumber)
        println("the processedString is \(processedString)")
        for i in processedString {
            if i == "." {
               self.decimalAdded = true
            }
            arrayNumber.append(String(i))
        }
        
        arrayCopy = arrayNumber
        println("arrayCopy is \(arrayCopy)")
        if self.decimalAdded == true {
        for i in 0...self.arrayNumber.count-1 {
            if self.arrayNumber[self.arrayNumber.count - 1 - i] == "0" {
                arrayCopy.removeAtIndex(arrayCopy.endIndex - 1)
            }
            else if self.arrayNumber[self.arrayNumber.count - 1 - i] == "."{
                arrayCopy.removeAtIndex(arrayCopy.endIndex - 1)
                self.decimalAdded = false
                break
            } else {
                break
            }
        }
        self.arrayNumber = arrayCopy
        }
        
        
    }
    
    // When the user presses the +/- button
    // the changeSign function manages to change the arraySign accordingly
    func changeSign() {
        if self.arraySign == [""] {
            self.arraySign = ["-"]
            self.negativeNumber = true
        } else if self.arraySign == ["-"] {
            self.arraySign = [""]
            self.negativeNumber = false
        }
    }
    
    // When the user presses one of the digits on the calculator keyboard 
    // the addDigit function manages to change the arrayNumber accordingly
    func addDigit(digitToAdd: String) {
        // for the first digit pressed, we need to take care of the "0" present by default in self.arrayNumber
        if self.arrayNumber == ["0"] {
            self.arrayNumber = []
        }
        
        // We don't want the user to enter more than 9 digits (similar to the Apple calculator app)
        var numberOfDigitsSoFar: Int = 0
        if self.decimalAdded == true {
            numberOfDigitsSoFar = self.arrayNumber.count - 1
        } else {
            numberOfDigitsSoFar = self.arrayNumber.count
        }
        
        if numberOfDigitsSoFar < 9{
            if digitToAdd == "." && self.decimalAdded == false {
                if self.arrayNumber == [] {
                  self.arrayNumber.append("0")
                }
                self.arrayNumber.append(".")
                self.decimalAdded = true
            } else if digitToAdd == "." && self.decimalAdded == true {
                println("addDigit(): already added a decimal point")
            } else {
                self.arrayNumber.append(digitToAdd)
            }
        } else {
            println("addDigit(): not adding \(digitToAdd) because too many digits ")
        }
    }
    
    // turnIntoDouble() is used to turn our array holding digits and the one holding the sign of the number into a real number so we can do calculations on that number
    func turnIntoDouble()->Double {
        var combinedArray = self.arraySign + self.arrayNumber
        var tempString = "".join(combinedArray)
        self.doubleNumber = (tempString as NSString).doubleValue
        return self.doubleNumber!
    }
    
    func turnIntoFormattedString()->String {
        var arrayNumberCopy = self.arrayNumber
        
        // The numberOfIntegers helps us figure out if we need "," separators for large numbers
        var numberOfIntegers = 1
        if self.decimalAdded == true {
            numberOfIntegers = find(self.arrayNumber, ".")!
      } else {
            numberOfIntegers = self.arrayNumber.count
        }
        
        if numberOfIntegers > 3 {
            for i in 1...numberOfIntegers - 1 {
                if i % 3 == 0 {
                    arrayNumberCopy.insert(",", atIndex: numberOfIntegers - i)
                    println("inserted one , at \(i)")
                }
            }
        }
        println("addDigit(): the arrayNumber is \(self.arrayNumber) (\(numberOfIntegers) Integers)")
        var combinedArray = self.arraySign + arrayNumberCopy
        var finalString = "".join(combinedArray)
        return finalString
    }
    
}
