// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var numString = "09"
var realNum = numString.toInt()!
realNum += 2

var newNumString = " 1"
var newRealNum = newNumString.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).toInt()!

