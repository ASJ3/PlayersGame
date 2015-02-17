// Playground - noun: a place where people can play

import UIKit

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


