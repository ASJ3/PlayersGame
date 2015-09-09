//
//  QuizListVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 8/8/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//
//CoreData code based on tutorial from http://www.raywenderlich.com/85578/first-core-data-app-using-swift
//Group by function in CoreData based on http://stackoverflow.com/questions/29562104/ios-swift-core-data-counting-child-entities

import UIKit
import CoreData

//class QuizListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, QuizVCDelegate {
class QuizListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var words = [AnyObject]()
    var stringResultsArray = [AnyObject]()
    var categoryFromList = ["category": String(), "wordCount": String()]
    var quizListInitialArray = [AnyObject]()
    var selectedLists = [String: String]()
    var quizStartButton = UIBarButtonItem()

    var wordList = [NSManagedObject]()
    
    
    var finalNumberArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List Selection"
        
        self.quizStartButton = UIBarButtonItem(title: "Start", style: .Plain, target: self, action:"showQuiz:")
        self.quizStartButton.enabled = false
        self.navigationItem.setRightBarButtonItem(quizStartButton, animated: true)
        
    }
    
    func showQuiz(Sender: AnyObject) {
        println("QuizListVC: ShowQuiz(): calling createQuizList() then emptyQuizList()")
        
        createQuizList()
        emptyQuizList()
        
        //Now that the QuizEntry Core Data entity is empty, we're going to add to it the 50 words randomly selected
        for i in self.finalNumberArray {
            
            var nativeWord = self.wordList[i].valueForKey("word") as? String
            var nativeFirst = self.wordList[i].valueForKey("wordFirst") as? String
            var translatedWord = self.wordList[i].valueForKey("translation") as? String
            var translatedFirst = self.wordList[i].valueForKey("translationFirst") as? String
            var translatedGender = self.wordList[i].valueForKey("gender") as? String
            var wordCategory = self.wordList[i].valueForKey("category") as? String


            addQuizWord(nativeWord!, wordFirst: nativeFirst!, translation: translatedWord!, translationFirst: translatedFirst!, gender: translatedGender!, category: wordCategory!, answeredRight: false, shownAlready: false)
//            println("ShowQuiz() Added \(nativeWord!) (\(translatedWord!))")
        }
        
//        let secondViewController:QuizVC = QuizVC()
//        self.presentViewController(secondViewController, animated: true, completion: nil)
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let QuizScreen = storyboard.instantiateViewControllerWithIdentifier("QuizViewController") as! QuizVC
        //        // ALEXIS: Now we're passing to the 'authorInfoVC' AuthorViewController the author ID so that it knows what info to display
        //        authorInfoVC.contributorID = self.authorInfo!
        //        if let passingName = self.authorName.text {
        //            authorInfoVC.textForAuthorName = passingName
        //        }

//        QuizScreen.delegate = self
//        self.presentViewController(QuizScreen, animated: true, completion: nil)
        self.navigationController?.pushViewController(QuizScreen, animated: true)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stringResultsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wordCell") as! UITableViewCell
        
        var categoryName = self.stringResultsArray[indexPath.row]["category"] as! String
        
        cell.textLabel!.text = categoryName
        cell.detailTextLabel?.text = self.stringResultsArray[indexPath.row]["wordCount"] as! String + " words"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let mySelectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        var textOfCell = mySelectedCell.textLabel!.text
        
        if mySelectedCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.None
            self.selectedLists[textOfCell!] = nil
        }
        else {
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            self.selectedLists[textOfCell!] = textOfCell
        }
        
        if self.selectedLists.count > 0 {
            self.quizStartButton.enabled = true
        } else {
            self.quizStartButton.enabled = false
        }
        
        println("QuizListVC: the list of selected words now has \(self.selectedLists.count) selections")
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Resetting stringResultsArray to empty
        self.stringResultsArray = []
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        
        let fetchRequest = NSFetchRequest(entityName:"WordEntry")
        
        //sortDescriptor is to enable us to sort the list of category alphabetically, to display it in the tableView
        let sortDescriptor = NSSortDescriptor(key: "category", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let countExpression = NSExpression(format: "count:(wordFirst)")
        let countED = NSExpressionDescription()
        countED.expression = countExpression
        countED.name = "wordCount"
        countED.expressionResultType = .Integer32AttributeType
        
        fetchRequest.propertiesToFetch = ["category", countED]
        //Here we are indicating that the fetchRequest will be an array of dictionaries
        fetchRequest.resultType = .DictionaryResultType
        fetchRequest.propertiesToGroupBy = ["category"]
        
        //3
        var error: NSError?
        
        if let results = managedContext.executeFetchRequest(fetchRequest,
            error: &error) {
                words = results
                
                for i in 0...results.count-1 {
                    categoryFromList["category"] = words[i]["category"] as? String
                    
                    
                    if let intCount = words[i]["wordCount"]! as? Int {
                        categoryFromList["wordCount"] = String(intCount)
                    }
                    
                    self.stringResultsArray.append(categoryFromList)
                }
                
                println("QuizListVC: stringsResultArray now has \(self.stringResultsArray.count) categories")
//                println("QuizListVC: stringsResultArray's first category is \(self.stringResultsArray[0])")
                
                
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
            
        }
    }
    
    
    //createQuizList() puts 50 words from the selected categories in the QuizEntry CoreData entity
    func createQuizList() {
        
        //Make quizListInitialArray empty, as we are going to put new words from the selected categories in it
        self.quizListInitialArray = []
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"WordEntry")
    
        //create an array "filter" which stores the name of the categories selected for the quiz
        var filter = [String]()
        for (key, value) in self.selectedLists {
            filter.append(value)
        }
        println("QuizListVC: createQuizList() filter is \(filter)")
        
        //Use the categories in the "filter" array to only return the words of the categories selected 
        //in the QuizListVC table
        let predicate = NSPredicate(format: "category IN %@", filter)
        fetchRequest.predicate = predicate
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            //Storing in wordList all the words from the categories we chose to be quizzed on
            self.wordList = results
            
            println("QuizListVC: createQuizList() the number of fetched words is \(self.wordList.count)")

            self.finalNumberArray = randomArray(self.wordList.count)
            println("QuizListVC: createQuizList() finalNumberArray has \(finalNumberArray.count) words whose values are \(finalNumberArray)")
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        
    }
    
    //randomArray() will give an array containing 20 unique numbers that we'll then use to fetch random words from our quizListInitialArray
    func randomArray(maxNum: Int) -> [Int] {
        var numberArray = [Int]()
        var firstNumToSwap = Int()
        var secondNumToSwap = Int()
        var smallerArray = [Int]()
        
        for i in 0..<maxNum {
            numberArray.append(i)
        }
        
        for i in 0..<numberArray.count {
            firstNumToSwap = randRange(0, upper: maxNum-1)
            secondNumToSwap = randRange(0, upper: maxNum-1)
            
//            println("QuizListVC: The random numbers are \(firstNumToSwap) and \(secondNumToSwap)")
            
            swap(&numberArray[firstNumToSwap], &numberArray[secondNumToSwap])
        }
        
        for i in 0...19 {
            smallerArray.append(numberArray[i])
        }

        return smallerArray
    }
    
    //randRange() returns a random positive Integer from within a range
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    
    func emptyQuizList() {
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
        println("emptyQuizList() number of words in QuizList is \(fetchedResults.count)")
        
        for entity in fetchedResults {
            managedContext.deleteObject(entity)
        }
        managedContext.save(nil)
        
        let fetchedResultsAfterDeletion =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [NSManagedObject]
        
        println("emptyQuizList() now number of words in fetchedResults2 is \(fetchedResultsAfterDeletion.count)")

    }
    
    
    //This function is to create an initial quiz list of 1 entry, which is "blank" and not a real word
    func addQuizWord(word: String, wordFirst: String, translation: String, translationFirst: String, gender: String, category: String, answeredRight: Bool, shownAlready: Bool) {
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
//        words.append(wordUnit)
    }

    
//    func closeOwnVC() {
//        println("QuizListVC closeOwnVC()")
//        
//        //Pop the QuizListVC so that when the user will close the view in QuizVC they will be going directly to the main menu and not back to QuizListVC
//        if let navController = self.navigationController {
//            navController.popViewControllerAnimated(false)
//        }
//    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
