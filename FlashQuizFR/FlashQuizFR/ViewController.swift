//
//  ViewController.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 7/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    //**********
    var gradient = CAGradientLayer()
    var bottomColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 219.0/255.0, alpha: 1.0).CGColor as CGColorRef
    var topColor = UIColor(red: 251.0/255.0, green: 251.0/255.0, blue: 242.0/255.0, alpha: 0.5).CGColor as CGColorRef
    @IBOutlet var mainView: UIView!
    //**********
    
//    @IBOutlet weak var beforeLabel: UILabel!
//    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var continueQuizButton: UIButton!
    var wordListArray = NSMutableArray()
    var wordFromList = WordStruct(identifierNumber: String(), group: String(), subgroup: String(), word: String(), wordFirst: String(), translation: String(), translationFirst: String(), details: String(), category: String())
//        var wordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "details":String(), "category":String()]
    
    var words = [NSManagedObject]()
    var countsInQuizList = 0
    var countsInWordEntryList = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "Main Menu"
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"WordEntry")
        
        //3
        //        var error: NSError?
        
        let fetchedResults =
        (try! managedContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
        self.countsInWordEntryList = fetchedResults.count
        
        if self.countsInWordEntryList == 0 {
            
            //TRIAL: figuring out which lists of words have been purchased/loaded to CoreData from wordListStatus plist
            let ListStatusPath = NSBundle.mainBundle().pathForResource("wordListStatus", ofType: "plist")
            let ListStatusArray = NSMutableArray(contentsOfFile: ListStatusPath!)!
            
            //If the "loaded" field of a list is true, then it means the words
            //in this list have been uploaded to CoreData.
            //If the field value is false, then we need to use wordDictionary plist
            //and upload the words from that list to CoreData
            
//            if ListStatusArray[0].valueForKey("loaded") as? Bool == false {
                //            self.beforeLabel.text = "list not yet loaded onto CoreData"
                
                //Loading all words and their translation from the wordDictionary plist
                let wordListPath = NSBundle.mainBundle().pathForResource("wordDictionary", ofType: "plist")
                wordListArray = NSMutableArray(contentsOfFile: wordListPath!)!
                
                print("ViewVC: count of words in wordListArray is \(wordListArray.count) and first word is \(wordListArray[0])")
                
                for word in wordListArray {
                    
                    wordFromList.identifierNumber = word["identifierNum"] as! String
                    wordFromList.group = word["group"] as! String
                    wordFromList.subgroup = word["subgroup"] as! String
                    wordFromList.word = word["word"] as! String
                    wordFromList.wordFirst = word["wordFirst"] as! String
                    wordFromList.translation = word["translation"] as! String
                    wordFromList.translationFirst = word["translationFirst"] as! String
                    wordFromList.details = word["details"] as! String
                    wordFromList.category = word["category"] as! String
                    
                    if wordFromList.word == "train station" {
                        print("ViewController just before saveName(): identifierNumber: \(wordFromList.identifierNumber), group: \(wordFromList.group), subgroup: \(wordFromList.subgroup), word: \(wordFromList.word), translation: \(wordFromList.translation)")
                    }
                    
                    if wordFromList.word == "scarf" {
                        print("ViewController just before saveName(): identifierNumber: \(wordFromList.identifierNumber), group: \(wordFromList.group), subgroup: \(wordFromList.subgroup), word: \(wordFromList.word), translation: \(wordFromList.translation)")
                    }
                    
                    
                    self.saveName(wordFromList.identifierNumber, group: wordFromList.group, subgroup: wordFromList.subgroup, word: wordFromList.word, wordFirst: wordFromList.wordFirst, translation: wordFromList.translation, translationFirst: wordFromList.translationFirst, details: wordFromList.details, category: wordFromList.category, timesCorrect: 0, timesQuizzed: 0)
                }
                
                //Change the "loaded" status to true for the word list in wordListStatus plist
                ListStatusArray[0].setValue(true, forKey: "loaded")
                ListStatusArray.writeToFile(ListStatusPath!, atomically: true)
                //            self.status.text = "list now loaded onto CoreData"
//            }
            
        } else {
//            self.beforeLabel.text = "WordEntry list now loaded onto CoreData"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //**********
        self.gradient.frame = self.mainView.bounds
        self.gradient.colors = [self.topColor, self.bottomColor]
        self.gradient.locations = [0.5, 0.9]
//        self.mainView.layer.insertSublayer(self.gradient, atIndex: 0)
        //**********
        
        print("ViewController viewWillAppear() started")
        
        //Figuring out if a real quizList (i.e. one with a list > 1 word) already exists
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"QuizEntry")
        
        //3
//        var error: NSError?
        
        let fetchedResults =
        (try! managedContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
        self.countsInQuizList = fetchedResults.count
        
        if self.countsInQuizList <= 5 {
            print("ViewController viewWillAppear() no QuizEntry core data table")
            self.initializeQuizList("EmptyWord", wordFirst: "EmptyLetter", translation: "EmptyWord", translationFirst: "EmptyLetter", details: "EmptyWord", category: "EmptyCategory", answeredRight: false, shownAlready: false)
            self.continueQuizButton.hidden = true
        } else {
            self.continueQuizButton.hidden = false
        }
        
        print("ViewController viewWillAppear() number of words in QuizList is \(fetchedResults.count)")
    }
    
    func saveName(identifierNumber: String, group: String, subgroup: String, word: String, wordFirst: String, translation: String, translationFirst: String, details: String, category: String, timesCorrect: Int, timesQuizzed: Int) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("WordEntry",
            inManagedObjectContext:
            managedContext)
        
        let wordUnit = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        wordUnit.setValue(word, forKey: "identifierNumber")
        wordUnit.setValue(word, forKey: "group")
        wordUnit.setValue(word, forKey: "subgroup")
        wordUnit.setValue(word, forKey: "word")
        wordUnit.setValue(translation, forKey: "translation")
        wordUnit.setValue(wordFirst, forKey: "wordFirst")
        wordUnit.setValue(translationFirst, forKey: "translationFirst")
        wordUnit.setValue(details, forKey: "details")
        wordUnit.setValue(category, forKey: "category")
        wordUnit.setValue(timesCorrect, forKey: "timesCorrect")
        wordUnit.setValue(timesQuizzed, forKey: "timesQuizzed")
        
        //4
        var error: NSError?
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error?.userInfo)")
        }
        //5
        words.append(wordUnit)
    }
    
    
    //This function is to create an initial quiz list of 1 entry, which is "blank" and not a real word
    func initializeQuizList(word: String, wordFirst: String, translation: String, translationFirst: String, details: String, category: String, answeredRight: Bool, shownAlready: Bool) {
        if self.countsInQuizList <= 2 {
            print("***VC: adding one to quizEntry")
            //1
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext!
            
            //2
            let entity =  NSEntityDescription.entityForName("QuizEntry",
                inManagedObjectContext:
                managedContext)
            
            let wordUnit = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext:managedContext)
            
            //3
            wordUnit.setValue(word, forKey: "word")
            wordUnit.setValue(translation, forKey: "translation")
            wordUnit.setValue(wordFirst, forKey: "wordFirst")
            wordUnit.setValue(translationFirst, forKey: "translationFirst")
            wordUnit.setValue(details, forKey: "details")
            wordUnit.setValue(category, forKey: "category")
            wordUnit.setValue(answeredRight, forKey: "answeredRight")
            wordUnit.setValue(shownAlready, forKey: "shownAlready")
            
            //4
            var error: NSError?
            do {
                try managedContext.save()
            } catch let error1 as NSError {
                error = error1
                print("Could not save \(error), \(error?.userInfo)")
            }
            //5
            words.append(wordUnit)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

