//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var array = ["hello","Goodbye","maybe","enough"]

var dicto1 = ["latitude": 0.01, "longitude": 10.0]
var dicto2 = ["latitude": 0.02, "longitude": 11.0]
var dicto3 = ["latitude": 0.03, "longitude": 13.0]
var dicto4 = ["latitude": 0.04, "longitude": 14.0]

//println("the value is \(dicto1["latitude"]!)")
var dictFinal = [dicto1, dicto2, dicto3, dicto4]

for i in 0..<array.count {
    println("the number is \(i) and the value is \(array[i])")
}

for i in 0..<dictFinal.count {
    var latitude =  dictFinal[i]["latitude"]
    println("the number is \(i), the latitude is: \(latitude!)")
    println("the number is \(i) and the value is \(dictFinal[i])")
}