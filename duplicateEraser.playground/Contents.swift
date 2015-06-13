//: Playground - noun: a place where people can play

import UIKit

var str = "Consciousness, Vast Cosmos, Consciousness, Cosmos, Vast Cosmos, Consciousness, Conscious"
var myArray = str.componentsSeparatedByString(",")
var myArrayCopy = [String]()

for i in 0..<myArray.count {
    //Trimming whitespaces at the beginning and the end of each word in the array
    //Appending the cleaned words to myArrayCopy
    myArrayCopy.append(myArray[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
}

myArray
myArrayCopy

var titleArray = [String]()

for i in 0..<myArrayCopy.count {
    var isDuplicate = false
    
    for j in 0..<i {
        if myArrayCopy[i] == myArrayCopy[j] {
        println("\(myArrayCopy[i]) is already added to titleArray")
            isDuplicate = true
            break
        }
    }
    
    if isDuplicate == false {
        titleArray.append(myArrayCopy[i])
    }
}

titleArray


