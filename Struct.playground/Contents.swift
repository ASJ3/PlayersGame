//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var authorName = "new Author"
var termName = "new Term"

struct quoteData {
    var authorName = "Author"
    var termName = "Term"
}

var newQuoteDT = quoteData()

println("\(newQuoteDT.authorName)")



newQuoteDT.termName = "Term 3"

newQuoteDT.termName

var fourthQuote: quoteData?


fourthQuote?.termName!




