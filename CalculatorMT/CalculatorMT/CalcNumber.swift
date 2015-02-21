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
    
    // When the user presses the +/- button
    // the changeSign function manages to change the arraySign accordingly
    func changeSign(sign: String) {
        if sign == "-" {
            self.arraySign = ["-"]
            self.negativeNumber = true
        } else if sign == "" {
            self.arraySign = [""]
            self.negativeNumber = false
        }
    }
    
    // When the user presses one of the digits on the calculator keyboard 
    // the addDigit function manages to change the arrayNumber accordingly
    func addDigit(digitToAdd: String) {
        if digitToAdd == "." && self.decimalAdded == false {
            self.decimalAdded = true
        }
        self.arrayNumber.append(digitToAdd)
        
    }
    
    // turnIntoDouble() is used to turn our array holding digits and the one holding the sign of the number into a real number so we can do calculations on that number
    func turnIntoDouble()->Double {
        var combinedArray = self.arraySign + self.arrayNumber
        var tempString = "".join(combinedArray)
        self.doubleNumber = (tempString as NSString).doubleValue
        return self.doubleNumber!
    }
    
    func turnIntoFormattedString()->String {
        
        
        return "hello"
    }
    
}
