//
//  QuizVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 8/12/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import CoreData

class QuizVC: UIViewController {
    @IBOutlet weak var wordLabel: UILabel!
    @IBAction func showNext(sender: AnyObject) {
        displayWord()
    }
    var wordsShown = 0
    var rightAnswers = 0
    var quizWordUnit = QuizStruct(word: String(), wordFirst: String(), translation: String(), translationFirst: String(), gender: String(), category: String(), shownAlready: String(), answeredRight: String(), quizzedWord: String())
    var quizzedWordList = [QuizStruct]()

    
    @IBAction func closeVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            
            for word in results {
                self.quizWordUnit.word = word.valueForKey("word") as! String
                self.quizWordUnit.wordFirst = word.valueForKey("wordFirst") as! String
                self.quizWordUnit.translation = word.valueForKey("translation") as! String
                self.quizWordUnit.translationFirst = word.valueForKey("translationFirst") as! String
                self.quizWordUnit.gender = word.valueForKey("gender") as! String
                self.quizWordUnit.category = word.valueForKey("category") as! String
                self.quizWordUnit.answeredRight = word.valueForKey("answeredRight") as! String
                self.quizWordUnit.quizzedWord = word.valueForKey("quizzedWord") as! String
                self.quizWordUnit.shownAlready = word.valueForKey("shownAlready") as! String
                
                self.quizzedWordList.append(quizWordUnit)
                
                if self.quizWordUnit.shownAlready == "Yes" {
                    self.wordsShown += 1
                    
                    if self.quizWordUnit.answeredRight == "Yes" {
                        self.rightAnswers += 1
                    }
                }
            }
            println("QuizVC: Score: \(self.rightAnswers) / \(self.wordsShown)")
            displayWord()
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func displayWord() {
        for i in 0..<self.quizzedWordList.count {
            println("displayWord() Looking at \(self.quizzedWordList[i])")
            var shownStatus = self.quizzedWordList[i].shownAlready as String
            if shownStatus == "No" {
                self.wordLabel.text = self.quizzedWordList[i].word as String
                self.quizzedWordList[i].shownAlready = "Yes"
                break
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
