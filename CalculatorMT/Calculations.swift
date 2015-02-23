//
//  Calculations.swift
//  CalculatorMT
//
//  Created by Alexis Saint-Jean on 2/22/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import Foundation

class Calculations {
    var firstNumber: CalcNumber
    var secondNumber: CalcNumber
    var operation: String = ""
    init(ArrayOfNumbers: [CalcNumber]) {
        self.firstNumber = ArrayOfNumbers[0]
        self.secondNumber = ArrayOfNumbers[1]
    }
    func operate(operation: String)-> Double {
        switch(operation) {
            case "+":
                return self.firstNumber.turnIntoDouble() + self.secondNumber.turnIntoDouble()
            case "-":
                return self.firstNumber.turnIntoDouble() - self.secondNumber.turnIntoDouble()
            case "x":
                return self.firstNumber.turnIntoDouble() * self.secondNumber.turnIntoDouble()
            case "/":
                if self.secondNumber.turnIntoDouble() == 0 {
                    println("Calculations: trying to divide by 0")
                    return 0.0
                } else {
                return self.firstNumber.turnIntoDouble() / self.secondNumber.turnIntoDouble()
            }
            default:
                return 0.0
        }
    }
}
