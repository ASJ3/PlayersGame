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
    
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var continueQuizButton: UIButton!
    var wordListArray = NSMutableArray()
    var wordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "gender":String(), "category":String()]
    
    var words = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TRIAL: figuring out which lists of words have been purchased/loaded to CoreData from wordListStatus plist
        var ListStatusPath = NSBundle.mainBundle().pathForResource("wordListStatus", ofType: "plist")
        var ListStatusArray = NSMutableArray(contentsOfFile: ListStatusPath!)!
        
        //If the "loaded" field of a list is true, then it means the words
        //in this list have been uploaded to CoreData.
        //If the field value is false, then we need to use wordDictionary plist
        //and upload the words from that list to CoreData
        if ListStatusArray[0].valueForKey("loaded") as? Bool == false {
            self.beforeLabel.text = "list not yet loaded onto CoreData"
            
            //Loading all words and their translation from the wordDictionary plist
            var wordListPath = NSBundle.mainBundle().pathForResource("wordDictionary", ofType: "plist")
            wordListArray = NSMutableArray(contentsOfFile: wordListPath!)!
            
            println("ViewVC: count of words in wordListArray is \(wordListArray.count)")
            
            for word in wordListArray {
                
                wordFromList["word"] = word["word"] as? String
                wordFromList["wordFirst"] = word["wordFirst"] as? String
                wordFromList["translation"] = word["translation"] as? String
                wordFromList["translationFirst"] = word["translationFirst"] as? String
                wordFromList["gender"] = word["gender"] as? String
                wordFromList["category"] = word["category"] as? String
                
                self.saveName(wordFromList["word"]!, wordFirst: wordFromList["wordFirst"]!, translation: wordFromList["translation"]!, translationFirst: wordFromList["translationFirst"]!, gender: wordFromList["gender"]!, category: wordFromList["category"]!, timesCorrect: 0, timesQuizzed: 0)
            }
            
            //Change the "loaded" status to true for the word list in wordListStatus plist
            ListStatusArray[0].setValue(true, forKey: "loaded")
            ListStatusArray.writeToFile(ListStatusPath!, atomically: true)
            self.status.text = "list now loaded onto CoreData"
            
        } else {
            self.beforeLabel.text = "list now loaded onto CoreData"
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
        
        println("ViewController viewWillAppear() started")
        
        //Figuring out if a real quizList (i.e. one with a list > 1 word) already exists
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"QuizEntry")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [NSManagedObject]
        if fetchedResults.count <= 1 {
            println("ViewController viewDidLoad() no QuizEntry core data table")
            self.initializeQuizList("EmptyWord", wordFirst: "EmptyLetter", translation: "EmptyWord", translationFirst: "EmptyLetter", gender: "EmptyWord", category: "EmptyCategory", answeredRight: false, shownAlready: false)
            self.continueQuizButton.hidden = true
        } else {
            self.continueQuizButton.hidden = false
        }
        
        println("ViewController viewWillAppear() number of words in QuizList is \(fetchedResults.count)")
    }
    
    func saveName(word: String, wordFirst: String, translation: String, translationFirst: String, gender: String, category: String, timesCorrect: Int, timesQuizzed: Int) {
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
        wordUnit.setValue(word, forKey: "word")
        wordUnit.setValue(translation, forKey: "translation")
        wordUnit.setValue(wordFirst, forKey: "wordFirst")
        wordUnit.setValue(translationFirst, forKey: "translationFirst")
        wordUnit.setValue(gender, forKey: "gender")
        wordUnit.setValue(category, forKey: "category")
        wordUnit.setValue(timesCorrect, forKey: "timesCorrect")
        wordUnit.setValue(timesQuizzed, forKey: "timesQuizzed")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        //5
        words.append(wordUnit)
    }
    
    
    //This function is to create an initial quiz list of 1 entry, which is "blank" and not a real word
    func initializeQuizList(word: String, wordFirst: String, translation: String, translationFirst: String, gender: String, category: String, answeredRight: Bool, shownAlready: Bool) {
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
        wordUnit.setValue(gender, forKey: "gender")
        wordUnit.setValue(category, forKey: "category")
        wordUnit.setValue(answeredRight, forKey: "answeredRight")
        wordUnit.setValue(shownAlready, forKey: "shownAlready")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        //5
        words.append(wordUnit)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

