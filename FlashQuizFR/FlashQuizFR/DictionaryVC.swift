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
    var filter = "corps"
//    var filterOverride = String()
    var nativeFirstArray = [String]()
    var uniqueNativeFirstArray = [String]()
    var nativeWordList = [String: [AnyObject]]()
    var sortedNativeWordList = [AnyObject]()
    var wordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "gender":String(), "category":String()]
    var languageUsed = "English"
    var titleSource = "word"
    var subtitleSource = "translation"
    var titleFirst = "wordFirst"
    var subtitleFirst = "translationFirst"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = "\"The List\""
        
        //Depending on the value of languageUsed the words in the title/subtitle will be either English or French
        if self.languageUsed == "English" {
            self.titleSource = "word"
            self.subtitleSource = "translation"
            self.titleFirst = "wordFirst"
            self.subtitleFirst = "translationFirst"
        } else {
            self.titleSource = "translation"
            self.subtitleSource = "word"
            self.titleFirst = "translationFirst"
            self.subtitleFirst = "wordFirst"
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    //The following 5 functions are to set up the table
    //1: Indicate the number of sections in the table (one section for each letter)
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sortedNativeWordList.count
    }
    
    //2: Indicate the title of each section (i.e. the letter by which each word in section begins)
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionLetterHeader = self.sortedNativeWordList[section][0].objectForKey("wordFirst") as? String
        return sectionLetterHeader?.uppercaseString
    }
    
    //3: Indicate the number of rows (i.e. words) in each section, based on CoreData
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedNativeWordList[section].count
    }
    
    //4: Indicate the values for the title/subtitle of each cell in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wordCell")!
        let person: AnyObject! = self.sortedNativeWordList[indexPath.section][indexPath.row]
        
        let wordGender = person.valueForKey("details") as! String
        let colorOfCell = cellColorPicker(wordGender)
        
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
        
        //Create a sortDescriptor to order the words in the list alphabetically
        let sortDescriptor = NSSortDescriptor(key: self.titleSource, ascending: true, selector: "localizedCaseInsensitiveCompare:")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //Create a filter to only return the words of the selected category, defined in "filter"
        
        let predicate = NSPredicate(format: "category == %@", filter)
        fetchRequest.predicate = predicate
        
        //3
        let error: NSError?
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                words = results
                
                for word in words {
                    //Finding the number of times each letter appears as first letter in the native language. This is to help us create the lettered sections in the table
                    let nativeFirstLetter = word.valueForKey(self.titleFirst) as! String
                    self.nativeFirstArray.append(nativeFirstLetter)
                    
                    wordFromList["word"] = word.valueForKey(self.titleSource) as? String
                    wordFromList["wordFirst"] = word.valueForKey(self.titleFirst) as? String
                    wordFromList["translation"] = word.valueForKey(self.subtitleSource) as? String
                    wordFromList["translationFirst"] = word.valueForKey(self.subtitleFirst) as? String
                    wordFromList["details"] = word.valueForKey("details") as? String
                    wordFromList["category"] = word.valueForKey("category") as? String
                    
                    //Append "word" to the array in the corresponding dictionary in nativeWordlist
                    if self.nativeWordList[nativeFirstLetter] == nil {
                        self.nativeWordList[nativeFirstLetter] = [wordFromList]
                    } else {
                        self.nativeWordList[nativeFirstLetter]!.append(wordFromList)
                    }
                }
                
                //Create a sorted array listing each unique letter
                uniqueNativeFirstArray = Array(Set(self.nativeFirstArray))
                uniqueNativeFirstArray.sortInPlace(){$0 <  $1}
                print("DictionaryVC: uniqueNativeFirstArray is : \(uniqueNativeFirstArray)")
                
                for i in uniqueNativeFirstArray {
                    let wordArrayForLetter = self.nativeWordList[i]
                    self.sortedNativeWordList.append(wordArrayForLetter!)
                }
            }
            
        } catch let error1 as NSError {
            error = error1
            print("saveAnswer() could not save \(error)")
        }
        
        
        
//        else {
//            print("Could not fetch \(error), \(error!.userInfo)")
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}