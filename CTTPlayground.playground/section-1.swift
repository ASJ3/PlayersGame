// Playground - noun: a place where people can play

import UIKit

var str = "<p>Michio Kaku is an American theoretical physicist, the Henry Semat Professor of Theoretical Physics in the City College.</p>"

var newString = str.stringByReplacingOccurrencesOfString("<p>", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).stringByReplacingOccurrencesOfString("</p>", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

newString = newString.stringByReplacingOccurrencesOfString("</p>", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
var testone = "hello here"
var testArray: [String] = []
testArray.count

//testArray.insert(testone, atIndex: 0)
