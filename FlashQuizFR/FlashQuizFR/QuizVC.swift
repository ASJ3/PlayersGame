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
    @IBOutlet weak var wordsDisplayed: UILabel!
    @IBOutlet weak var answerButton01: UIButton!
    @IBOutlet weak var answerButton02: UIButton!
    @IBOutlet weak var answerButton03: UIButton!
    @IBOutlet weak var answerButton04: UIButton!
    @IBOutlet weak var answerButton05: UIButton!
    
        @IBOutlet weak var nextButton: UIButton!
    @IBAction func showNext(sender: UIButton) {
        //When we click on the button to reach the last word of quizWordList then the "Next" button needs to disappear 
        //as it is not needed anymore
        if self.wordsShown == self.quizWordList.count-2 {
            self.nextButton.hidden = true
        }
        
        self.wordsShown += 1
        displayQuestion(wordsShown)
        
    }
    @IBAction func checkAnswer(sender: UIButton) {
    }
    
    var quizWordUnit = QuizStruct(word: String(), wordFirst: String(), translation: String(), translationFirst: String(), gender: String(), category: String(), shownAlready: String(), answeredRight: String(), quizzedWord: String())
    var quizWordList = [QuizStruct]()
    
    //When quizWordList is created from the QuizEntry CoreData entity, we store the numbers of words already shown and how many
    //of these words shown where answered correctly
    var wordsShown = 0
    var rightAnswers = 0
    

    @IBAction func closeVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //If we're at the last word of quizWordList then the "Next" button needs to disappear as it is not needed anymore
        if self.wordsShown == self.quizWordList.count-2 {
            self.nextButton.hidden = true
        }

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
                self.quizWordUnit.answeredRight = word.valueForKey("answeredRight") as! String
                self.quizWordUnit.quizzedWord = word.valueForKey("quizzedWord") as! String
                self.quizWordUnit.shownAlready = word.valueForKey("shownAlready") as! String
                
                self.quizWordList.append(quizWordUnit)
                
                //Increase the values of wordShown and rightAnswers, based on what's store in QuizEntry CoreData entity
                if self.quizWordUnit.shownAlready == "Yes" {
                    self.wordsShown += 1
                    
                    if self.quizWordUnit.answeredRight == "Yes" {
                        self.rightAnswers += 1
                    }
                }
            }

            displayQuestion(wordsShown)
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func displayQuestion(wordPosition: Int) {
        self.wordLabel.text = self.quizWordList[wordPosition].word as String
        self.quizWordList[wordPosition].shownAlready = "Yes"
        self.wordsDisplayed.text = String(self.wordsShown)
        
        updateAnswerButtons()
        
    }
    
    func updateAnswerButtons() {
        //Get the positions of 4 random words in quizWordList
        //Random start point after the current word's position
        var startPoint = randomNumberInRange(2, upper: 4)
        //Random start point after the current word's position
        var wordInterval = randomNumberInRange(2, upper: 5)
        var listOfWrongAnswers = [Int]()
        var nextWrongAnswer = wordsShown + startPoint
        
        for i in 0...3 {
            //nextWrongAnswer number cannot be > the number of words in quizWordList
            if nextWrongAnswer >= self.quizWordList.count {
                nextWrongAnswer -= self.quizWordList.count
            }
            listOfWrongAnswers.append(nextWrongAnswer)
            nextWrongAnswer += wordInterval
        }
        
        //Random index at which to put the right answer
        var rightAnswerPosition = randomNumberInRange(0, upper: 4)
        listOfWrongAnswers.insert(self.wordsShown, atIndex: rightAnswerPosition)
        
        println("updateAnswerButtons() the list is: \(listOfWrongAnswers)")
        
        var buttonList = [self.answerButton01, self.answerButton02, self.answerButton03, self.answerButton04, self.answerButton05]
        
        //Assigns the words to each button
        for i in 0..<buttonList.count {
            var textLabel = self.quizWordList[listOfWrongAnswers[i]].word as String
            buttonList[i].setTitle(textLabel, forState: .Normal)
        }
    }
    
    func randomNumberInRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
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
