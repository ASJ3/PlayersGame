//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var firstLetterArray = [["a": 0], ["b": 0], ["c": 0],["r": 0],["v": 0]]
//firstLetterArray["a"]
var secLetterArray = ["a": 0, "b": 0, "c": 0,"r": 0,"v": 0]
var secLetter = secLetterArray["a"]
secLetter! += 1
secLetter
secLetterArray
secLetterArray["a"] = secLetter
secLetterArray
secLetterArray["b"] = 3
secLetterArray

secLetterArray["w"] = 3
secLetterArray

var newArray = ["a": ["allegro", "advance", "armor"], "b": ["benefit", "bingo", "bonus"]]
newArray["a"]
newArray["a"]!.append("ammunition")

newArray["a"]
newArray["a"]!.insert("avanti", atIndex:0)
println("hello")
newArray

var newWord = "hello"
newWord.uppercaseString
var newDict = ["name": "hello", "loaded": true, "purchased": 1]
newDict["loaded"]


var nouvArray = ["a","b","d"]
for i in nouvArray {
    println("the letter is now \(i)")
}

newArray
var dicoArray = ["a": ["Alexis","Aurelien"], "s": ["Sylvain"]]
dicoArray["s"]!.append("Stephanie")
dicoArray["e"] = ["Emilie", "Elijah"]
dicoArray

var greetings = "hello"
greetings
var firstChar = Array(greetings)[0]
var toppings = ["pepperoni": "spicy", "pepper": "mild", "jalapeno":"hot"]
toppings["tomato"] = "sweet"
toppings
toppings["tomato"] = "zesty"
toppings
toppings["tomato"] = nil
toppings
toppings["parmesan"] = nil
toppings
var newDictArray = ["habits": "habits", "corps": "corps", "tranpsort": "transport"]
for (key,value) in newDictArray {
    print(value)
}

var numArray = [Int]()
for i in 0...49 {
    numArray.append(i)
    
}

numArray

swap(&numArray[0], &numArray[4])
numArray
swap(&numArray[0], &numArray[0])
numArray

func randRange (lower: Int , upper: Int) -> Int {
    return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
}

randRange(0, 30)
randRange(0, 30)
randRange(0, 30)
randRange(0, 30)

var superArray = ["Hello", "World", "How are", "YOU"]
var part = superArray[1]
