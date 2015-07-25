//
//  TestVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 7/22/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//
//CoreData code based on tutorial from http://www.raywenderlich.com/85578/first-core-data-app-using-swift

import UIKit
import CoreData

class TestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var words = [NSManagedObject]()
    var nativeFirstArray = [String]()
    var sortedNativeFirstArray = [AnyObject]()
    var NativeWordList = [String: [AnyObject]]()
    var wordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "gender":String()]


    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "\"The List\""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return words.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        let person = words[indexPath.row]
        cell.textLabel!.text = person.valueForKey("word") as? String
        var wordGender = person.valueForKey("gender") as! String
         cell.detailTextLabel?.text = person.valueForKey("translation") as! String + " (" + wordGender + ")"
        
        return cell
        }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"WordEntry")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            words = results
            
            //Finding the number of times each letter appears as first letter in the native language.
            //This is to help us create the lettered sections in the table
            for word in words {
                var nativeFirst = word.valueForKey("wordFirst") as? String
                self.nativeFirstArray.append(nativeFirst!)
            }
            
            //Sort the letters in nativeFirstArray in alphabetical order
            self.nativeFirstArray.sort(){$0 <  $1}
            //Create a sorted array listing each unique letter
            var uniqueNativeFirstArray = Array(Set(self.nativeFirstArray))
            uniqueNativeFirstArray.sort(){$0 <  $1}
            //Create an array listing the occurences of each letter in uniqueNativeFirstArray
            var uniqueNativeFirstCountArray = [Int]()
            
            for i in uniqueNativeFirstArray {
                var countOfLetterOccurences = 0
                for j in self.nativeFirstArray {
                    if j == i {
                    countOfLetterOccurences += 1
                    }
                }
                uniqueNativeFirstCountArray.append(countOfLetterOccurences)
            }
            
            println("TestVC: uniqueNativeFirstArray is : \(uniqueNativeFirstArray)")
            println("TestVC: uniqueNativeFirstCountArray is : \(uniqueNativeFirstCountArray)")
            
            //Add dictionaries to sorterNativeFirstArray that indicates each letter and how many words start by that letter 
            for i in 0...uniqueNativeFirstArray.count-1 {
                var dictKey = uniqueNativeFirstArray[i]
//                var dictLetterWordArray = []
//                var nativeFirstDict = [dictKey: dictCount]
//                self.sortedNativeFirstArray.append(nativeFirstDict)
                for word in words {
                    var nativeFirst = word.valueForKey("wordFirst") as? String
                    if nativeFirst! == dictKey {
                        wordFromList["word"] = word.valueForKey("word") as? String
                        wordFromList["wordFirst"] = word.valueForKey("wordFirst") as? String
                        wordFromList["translation"] = word.valueForKey("translation") as? String
                        wordFromList["translationFirst"] = word.valueForKey("translationFirst") as? String
                        wordFromList["gender"] = word.valueForKey("gender") as? String
                        
                        if self.NativeWordList[dictKey] == nil {
                            self.NativeWordList[dictKey] = [wordFromList]
                        } else {
                            self.NativeWordList[dictKey]!.append(wordFromList)
                        }
                        
                    }
                }
            }
            println("TestVC: NativeWordlist is: \(self.NativeWordList)")

        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    }
