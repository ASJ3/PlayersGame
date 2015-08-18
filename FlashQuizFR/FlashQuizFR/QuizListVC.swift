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




class QuizListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var words = [AnyObject]()
    var stringResultsArray = [AnyObject]()
    var categoryFromList = ["category": String(), "wordCount": String()]
    var quizListInitialArray = [AnyObject]()
    var selectedLists = [String: String]()
    var quizStartButton = UIBarButtonItem()
    var quizWordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "gender":String(), "category":String(), "quizzedWord":String(), "shownAlready":String(), "answeredRight":String()]
    var wordList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List Selection"
        
        self.quizStartButton = UIBarButtonItem(title: "Start", style: .Plain, target: self, action:"showQuiz:")
        self.quizStartButton.enabled = false
        self.navigationItem.setRightBarButtonItem(quizStartButton, animated: true)
        
    }
    
    func showQuiz(Sender: AnyObject) {
        println("ShowQuiz() started")
        println("ShowQuiz(): now calling createQuizList()")
        
        createQuizList()
        overWriteQuizList()
        
//        let secondViewController:QuizVC = QuizVC()
//        self.presentViewController(secondViewController, animated: true, completion: nil)
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let QuizScreen = storyboard.instantiateViewControllerWithIdentifier("QuizViewController") as! QuizVC
        //        // ALEXIS: Now we're passing to the 'authorInfoVC' AuthorViewController the author ID so that it knows what info to display
        //        authorInfoVC.contributorID = self.authorInfo!
        //        if let passingName = self.authorName.text {
        //            authorInfoVC.textForAuthorName = passingName
        //        }
                self.presentViewController(QuizScreen, animated: true, completion: nil)
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
                println("QuizListVC: count of categories to add to stringsResultArray: \(words.count)")
                
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
        println("QuizListVC: createQuizList(): filter is \(filter)")
        
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
            words = results
            
            println("the number of fetched results is \(words.count)")
            
            for word in words {
                
                var wordProcessed = word.valueForKey("word") as! String
                
                quizWordFromList["word"] = word.valueForKey("word") as? String
                quizWordFromList["wordFirst"] = word.valueForKey("wordFirst") as? String
                quizWordFromList["translation"] = word.valueForKey("translation") as? String
                quizWordFromList["translationFirst"] = word.valueForKey("translationFirst") as? String
                quizWordFromList["gender"] = word.valueForKey("gender") as? String
                quizWordFromList["category"] = word.valueForKey("category") as? String
                quizWordFromList["quizzedWord"] = "Yes"
                quizWordFromList["shownAlready"] = "No"
                quizWordFromList["answeredRight"] = "No"
                
//                println("appending word \(wordProcessed)")
                self.quizListInitialArray.append(quizWordFromList)
                
            }
            
            println("createQuizList(): the number of words within the quizListInitialArray is \(self.quizListInitialArray.count)")
            var finalNumberArray = randomArray(self.quizListInitialArray.count)
            println("createQuizList(): the number of words within the finalNumberArray is \(finalNumberArray.count)")
//            println("createQuizList(): the values of words within the finalNumberArray is \(finalNumberArray)")
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        
    }
    
    //randomArray() will give an array containing 50 unique numbers that we'll then use to fetch random words from our quizListInitialArray
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
        
        for i in 0...49 {
            smallerArray.append(numberArray[i])
        }

        return smallerArray
    }
    
    //randRange() returns a random positive Integer from within a range
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    
    func overWriteQuizList() {
        
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
        println("overWriteQuizList() number of words in QuizList is \(fetchedResults.count)")
        
        for entity in fetchedResults {
            var newInfo = entity.valueForKey("word") as! String
            println("newInfo is \(newInfo)")
            managedContext.deleteObject(entity)
        }
        managedContext.save(nil)
        
        let fetchedResults2 =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [NSManagedObject]
        println("overWriteQuizList() number of words in fetchedResults is \(fetchedResults.count)")
        
        println("overWriteQuizList() now number of words in fetchedResults2 is \(fetchedResults2.count)")
        
//        let fetchedResults =
//        managedContext.executeFetchRequest(fetchRequest,
//            error: &error) as? [NSManagedObject]
        
//        if let results = fetchedResults {
//            println("overWriteQuizList() number of words in QuizList is \(fetchedResults!.count)")
//            
//            var i = fetchedResults!.count
//            
//            //START LOOP
//            for i ; i != 0 ; i-- {
//                
//                //delete one result per time
//                var delete = fetchedResults![i - 1]
//                managedContext.deleteObject(delete)
//                if managedContext.save(&error){
//                    println("Person is deleted \(i)")
//                }else{
//                    println("Could not delete \(error), \(error!.userInfo)")
//                }
//            }
//            
//            println("overWriteQuizList() Now number of words in QuizList is \(fetchedResults!.count)")

            
            
//            for word in words {
//                //Finding the number of times each letter appears as first letter in the native language. This is to help us create the lettered sections in the table
//                var nativeFirstLetter = word.valueForKey("word") as! String
//                self.nativeFirstArray.append(nativeFirstLetter)
//                println("QuizListVC: overWriteQuizList(): the word is \(nativeFirstLetter)")
                
//                wordFromList["word"] = word.valueForKey(self.titleSource) as? String
//                wordFromList["wordFirst"] = word.valueForKey(self.titleFirst) as? String
//                wordFromList["translation"] = word.valueForKey(self.subtitleSource) as? String
//                wordFromList["translationFirst"] = word.valueForKey(self.subtitleFirst) as? String
//                wordFromList["gender"] = word.valueForKey("gender") as? String
//                wordFromList["category"] = word.valueForKey("category") as? String
                
                //Append "word" to the array in the corresponding dictionary in nativeWordlist
//                if self.nativeWordList[nativeFirstLetter] == nil {
//                    self.nativeWordList[nativeFirstLetter] = [wordFromList]
//                } else {
//                    self.nativeWordList[nativeFirstLetter]!.append(wordFromList)
//                }
                
//            }
            
            //Create a sorted array listing each unique letter
//            uniqueNativeFirstArray = Array(Set(self.nativeFirstArray))
//            uniqueNativeFirstArray.sort(){$0 <  $1}
//            println("DictionaryVC: uniqueNativeFirstArray is : \(uniqueNativeFirstArray)")
//            
//            for i in uniqueNativeFirstArray {
//                var wordArrayForLetter = self.nativeWordList[i]
//                self.sortedNativeWordList.append(wordArrayForLetter!)
//            }
            
            
//        } else {
//            println("Could not fetch \(error), \(error!.userInfo)")
//        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
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
