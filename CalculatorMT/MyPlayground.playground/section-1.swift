// Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

str.substringWithRange(Range<String.Index>(start: advance(str.startIndex, 1), end: str.endIndex))

var numStr = "-12345656999"
var turnToFloat = numStr.toInt()!
turnToFloat += 1

var newNum = 123456.999999
newNum += 1.0001


var newFloat = 123456.0
newFloat /= 1000000

var curFloat = "10000000000000000"
var newInt = curFloat.toInt()

var numstring: String
numstring = "12345.9999"

//var convertedNum = numstring.floatValue
//var endingDigits = currentDisplay.substringWithRange(Range<String.Index>(start: advance(currentDisplay.endIndex, -2), end: currentDisplay.endIndex))
var leftNumberPart = numstring.substringWithRange(Range<String.Index>(start: numstring.startIndex, end: advance(numstring.startIndex, 5)))
var rightNumberPart = numstring.substringWithRange(Range<String.Index>(start: advance(numstring.startIndex, 5+1), end: numstring.endIndex))
var newRightNum = pow(10.0, Double(4))

var result = Double(rightNumberPart.toInt()!) / newRightNum

var digits = "1234.5789"

let characterToFind: Character = "."

var characterPosition = 0

if let characterIndex = find(digits, characterToFind) {
    characterPosition = distance(digits.startIndex, characterIndex) // -> 7
} else {
    "'\(characterToFind)' not found"
}

var newRes = characterPosition + 1

var doubleNew: Double = 0.0
var floatNew: Float = 10.0
floatNew = Float(doubleNew) + 15

var sometext = "123455."
var otherText = "goodbye" + "hello"
var lastone = sometext.substringWithRange(Range<String.Index>(start: advance(sometext.endIndex, -1), end: sometext.endIndex))

var endText = Array<Character>(sometext)

endText[endText.count-1]

endText.removeAtIndex(endText.count - 1)
endText



//let newstring = "-".join(endText)

var array = ["a","b"]

let stringRepresentation = "".join(array)
var numasString = "123.78999"
var numasnum = (numasString as NSString).floatValue

var newText = "1234567"
var arrayNum: [String] = []

for i in newText {
    var storedNumber = 0
    println(i)
    
}

var newChar: Character = "u"

var newChar2: Character = "n"

var newString23 = String(newChar)

for i in newText {
    var stringVersion = String(i)
    arrayNum.append(stringVersion)
    
}
var variableH = arrayNum[0...arrayNum.count-2]

var variableZ = "".join(variableH)


var newArray = ["-","0"]
newArray.append("1")


//var stringRepresentation2 = "".join(arrayText)

newArray.last!
var array1 = ["a", "b", "c","d"]
var array2 = array1

array2.removeAtIndex(0)

array1
array2
println("hello first")
print("hello second")
println("hello third")
var helloArray = ["0","1"]
helloArray.count
var byebyeArray = []
byebyeArray.count

var arraySign = [""]
var numberArray = ["1","2","3","4"]

var combinedArray = arraySign + numberArray
find(combinedArray, "")!
var arrayNew = ["1","2",".","4","5","6","7"]
arrayNew.count
arrayNew.insert(",", atIndex: 4)
arrayNew.insert(",", atIndex: 1)
find(arrayNew, ".")!

var finalString = "123456.001"
var arrOfStrings = [String]()
for i in finalString {
    arrOfStrings.append(String(i))
}

println("\(arrOfStrings)")
var openingDouble:Double = 1.00000001
var newNewString = String(format:"%.9f", openingDouble)

var whyArray = ["1", "2", "3", "4","5","0","0","0", ".", "0","1","0","0","0"]
var hello = whyArray
hello

for i in 0...whyArray.count-1 {
    if whyArray[whyArray.count - 1 - i] == "0" {
        hello.removeAtIndex(hello.endIndex - 1 )
    } else {
        break
    }
}

hello

//for i in 0..< whyArray.count _ = {
//    whyArray[i]
//}








