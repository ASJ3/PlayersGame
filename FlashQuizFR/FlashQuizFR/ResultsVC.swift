//
//  ResultsVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 9/17/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import CoreData

class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var quizWordUnit = QuizStruct(word: String(), wordFirst: String(), translation: String(), translationFirst: String(), gender: String(), category: String(), shownAlready: Bool(), answeredRight: Bool())
    var quizWordList = [QuizStruct]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"QuizEntry")
        
        //3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            
            for word in results {
                self.quizWordUnit.word = word.valueForKey("word") as! String
                self.quizWordUnit.wordFirst = word.valueForKey("wordFirst") as! String
                self.quizWordUnit.translation = word.valueForKey("translation") as! String
                self.quizWordUnit.translationFirst = word.valueForKey("translationFirst") as! String
                self.quizWordUnit.gender = word.valueForKey("gender") as! String
                self.quizWordUnit.category = word.valueForKey("category") as! String
                self.quizWordUnit.answeredRight = word.valueForKey("answeredRight") as! Bool
                self.quizWordUnit.shownAlready = word.valueForKey("shownAlready") as! Bool
                
                self.quizWordList.append(quizWordUnit)
                
                //Increase the values of wordShown and rightAnswers, based on what's store in QuizEntry CoreData entity
//                if self.quizWordUnit.shownAlready == true {
//                    self.wordsShown += 1
//                }
//                if self.quizWordUnit.answeredRight == true {
//                    self.rightAnswers += 1
//                }
            }
            
            println("ResultsVC: viewDidLoad() quizWordList is \(self.quizWordList.count)")
            
            
            //Calling displayQuestion() using wordsShown ensures the latest unanswered word is shown any time the view appears
            //However if we've reached the end of the array of questions (i.e. wordsShown = array count)
            //then using wordShown means that displayQuestion() is looking for an index value that is greater than what's in the array
            //of questions. If this is the case, we need to show wordsShown - 1 instead.
            //We also need to disable the answer buttons otherwise the app will crash
//            if self.wordsShown == self.quizWordList.count {
//                println("QuizVC: viewWillAppear() showing last word only")
//                displayQuestion(wordsShown - 1)
//                self.answerButtonPushed = true
//            } else {
//                displayQuestion(wordsShown)
//            }
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        
        //Since we're showing a new question, the "Next" button needs to be hidden until an answer has been provided
//        self.nextButton.hidden = true
        
        //If we're showing the last word in the array of questions AND it has already been answered
        //then
        //        if self.wordsShown == self.quizWordList.count {
        //
        //            println("QuizVC: viewWillAppear() showing last word only")
        //        }
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quizWordList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wordCell") as! UITableViewCell
        
//        var categoryName = self.quizWordList[indexPath.row]["category"] as! String
        
        cell.textLabel!.text = self.quizWordList[indexPath.row].word
        cell.detailTextLabel?.text = self.quizWordList[indexPath.row].translation
        
        return cell
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
