//
//  DictionaryVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 7/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//
//CoreData code based on tutorial from http://www.raywenderlich.com/85578/first-core-data-app-using-swift


import UIKit
import CoreData

class DictionaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var words = [NSManagedObject]()
    var nativeFirstArray = [String]()
    var uniqueNativeFirstArray = [String]()
    var nativeWordList = [String: [AnyObject]]()
    var sortedNativeWordList = [AnyObject]()
    var wordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "gender":String()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = "\"The List\""
        
        // Do any additional setup after loading the view.
    }
    
    
    //The following 5 functions are to set up the table
    //1: Indicate the number of sections in the table (one section for each letter)
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sortedNativeWordList.count
    }
    
    //2: Indicate the title of each section (i.e. the letter by which each word in section begins)
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionLetterHeader = self.sortedNativeWordList[section][0].objectForKey("wordFirst") as? String
        return sectionLetterHeader?.uppercaseString
    }
    
    //3: Indicate the number of rows (i.e. words) in each section, based on CoreData
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedNativeWordList[section].count
    }
    
    //4: Indicate the values for the title/subtitle of each cell in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wordCell") as! UITableViewCell
        let person: AnyObject! = self.sortedNativeWordList[indexPath.section][indexPath.row]
        
        var wordGender = person.valueForKey("gender") as! String
        var colorOfCell = cellColorPicker(wordGender)
        
        cell.backgroundColor = colorOfCell
        cell.textLabel!.text = person.valueForKey("word") as? String
        cell.detailTextLabel?.text = person.valueForKey("translation") as! String + " (" + wordGender + ")"
        
        return cell
        
    }
    
    //5: Indicate the height of each cell in table
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    
    //cellColorPicker() indicate what background color a given cell in the table should have
    //based on a property of the word in that cell (i.e. blue/pink if the word is masculine/feminine
    func cellColorPicker(wordInfo: String) -> UIColor {
        var colorToReturn = UIColor()
        
        if wordInfo == "f" {
            colorToReturn = UIColor(red: 250.0/255.0, green: 230.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        } else if wordInfo == "m" {
            colorToReturn = UIColor(red: 229.0/255.0, green: 240.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        } else {
            colorToReturn = UIColor.clearColor()
        }
        
        return colorToReturn
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
                var nativeFirstLetter = word.valueForKey("wordFirst") as? String
                self.nativeFirstArray.append(nativeFirstLetter!)
            }
            
            
            //Create a sorted array listing each unique letter
            uniqueNativeFirstArray = Array(Set(self.nativeFirstArray))
            uniqueNativeFirstArray.sort(){$0 <  $1}
            println("DictionaryVC: uniqueNativeFirstArray is : \(uniqueNativeFirstArray)")
            
            //----------
            for firstLetter in uniqueNativeFirstArray {
                self.nativeWordList[firstLetter] = []
            }
            
            
            
            //----------
            
            
            //Add dictionaries to nativeWordList that indicates each letter and how many words start by that letter
            for firstLetter in uniqueNativeFirstArray {
                
                for word in words {
                    if firstLetter == word.valueForKey("wordFirst") as! String {
                        wordFromList["word"] = word.valueForKey("word") as? String
                        wordFromList["wordFirst"] = word.valueForKey("wordFirst") as? String
                        wordFromList["translation"] = word.valueForKey("translation") as? String
                        wordFromList["translationFirst"] = word.valueForKey("translationFirst") as? String
                        wordFromList["gender"] = word.valueForKey("gender") as? String
                        
                        //Append "word" to the array in the correspongind letter dictionary
                        //in nativeWordList
                            self.nativeWordList[firstLetter]!.append(wordFromList)
                        
                    }
                }
            }
            
            //Create the final list to use, sortedNativeWordList
            for i in uniqueNativeFirstArray {
                for (key, value) in self.nativeWordList {
                    if key == i {
                        self.sortedNativeWordList.append(value)
                        break
                    }
                }
            }
            
//            println("TestVC: sortedNativeWordlist is: \(self.sortedNativeWordList)")
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}