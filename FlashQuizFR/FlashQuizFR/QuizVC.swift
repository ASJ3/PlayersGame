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
    @IBOutlet weak var correctAnswers: UILabel!
    @IBOutlet weak var answerButton01: UIButton!
    @IBOutlet weak var answerButton02: UIButton!
    @IBOutlet weak var answerButton03: UIButton!
    @IBOutlet weak var answerButton04: UIButton!
    @IBOutlet weak var answerButton05: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var quizWordUnit = QuizStruct(word: String(), wordFirst: String(), translation: String(), translationFirst: String(), gender: String(), category: String(), shownAlready: String(), answeredRight: String(), quizzedWord: String())
    var quizWordList = [QuizStruct]()
    var currentQuestion = QuizStruct(word: String(), wordFirst: String(), translation: String(), translationFirst: String(), gender: String(), category: String(), shownAlready: String(), answeredRight: String(), quizzedWord: String())
    var nativeLanguagePicked = true
    var wrongAnswersList = [QuizStruct]()
    
    //When quizWordList is created from the QuizEntry CoreData entity, we store the numbers of words already shown and how many
    //of these words shown where answered correctly
    var wordsShown = 0
    var rightAnswers = 0
    
    
    @IBAction func showNext(sender: UIButton) {
        //When we reach the last word of quizWordList, "Next" button needs to disappear
//        if self.wordsShown == self.quizWordList.count-2 {
//            self.nextButton.hidden = true
//        }
        
        self.wordsShown += 1
        displayQuestion(wordsShown)
        self.nextButton.hidden = true
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        var AnswerChosenOtherLanguage = String()

        if self.nativeLanguagePicked == true {
            for i in self.wrongAnswersList {
                if i.translation == sender.titleLabel!.text! {
                    AnswerChosenOtherLanguage = i.word as String
                }
            }
        } else {
            for i in self.wrongAnswersList {
                if i.word == sender.titleLabel!.text! {
                    AnswerChosenOtherLanguage = i.translation as String
                }
            }
        }
        
        println("AnswerChosenOtherLanguage is \(AnswerChosenOtherLanguage)")
            if AnswerChosenOtherLanguage == self.wordLabel.text! {
            self.rightAnswers += 1
            self.correctAnswers.text = String(self.rightAnswers)
        } else {

        }
        var score = self.wordsShown + 1
        self.wordsDisplayed.text = String(score)
        self.nextButton.hidden = false
        
    }
    

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
        self.currentQuestion = self.quizWordList[wordPosition]
        var randomLanguage = randomNumberInRange(0, upper: 1)
        if randomLanguage == 0 {
            self.nativeLanguagePicked = false
        } else {
            self.nativeLanguagePicked = true
        }
        
        if self.nativeLanguagePicked == true {
            self.wordLabel.text = self.currentQuestion.word as String
        } else {
            self.wordLabel.text = self.currentQuestion.translation as String
        }
        
        self.currentQuestion.shownAlready = "Yes"
        self.wordsDisplayed.text = String(self.wordsShown)
        
        updateAnswerButtons()
    }
    
    
    func updateAnswerButtons() {
        var listOfWrongAnswers = randomWrongAnswers()
        
        //Random index at which to put the right answer
        var rightAnswerPosition = randomNumberInRange(0, upper: 4)
        listOfWrongAnswers.insert(self.wordsShown, atIndex: rightAnswerPosition)
        
        for i in listOfWrongAnswers {
            self.wrongAnswersList.append(self.quizWordList[i])
        }
        
        println("updateAnswerButtons() the list is: \(listOfWrongAnswers)")
        
        var buttonList = [self.answerButton01, self.answerButton02, self.answerButton03, self.answerButton04, self.answerButton05]
        
        //Assigns the words to each button
        if self.nativeLanguagePicked == true {
            for i in 0..<buttonList.count {
                var textLabel = self.quizWordList[listOfWrongAnswers[i]].translation as String
                buttonList[i].setTitle(textLabel, forState: .Normal)
            }
        } else {
            for i in 0..<buttonList.count {
                var textLabel = self.quizWordList[listOfWrongAnswers[i]].word as String
                buttonList[i].setTitle(textLabel, forState: .Normal)
            }
        }

    }
    
    
    //randomWrongAnswers returns Int index of words to use to provide wrong-answer choices
    func randomWrongAnswers()->[Int] {
        var listToReturn = [Int]()
        var sourceList = [Int]()
        for i in 0..<self.quizWordList.count {
            if i != self.wordsShown {
                sourceList.append(i)
            }
        }
        
        for i in 1...4 {
            var randomWrongAnswer = randomNumberInRange(0, upper: sourceList.count-1)
            listToReturn.append(sourceList[randomWrongAnswer])
            sourceList.removeAtIndex(randomWrongAnswer)
        }

        return listToReturn
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
