//
//  QuizVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 8/12/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore

protocol QuizVCDelegate {
    func closeOwnVC()
}

class QuizVC: UIViewController, CongratsVCDelegate {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var wordsDisplayed: UILabel!
    @IBOutlet weak var correctAnswers: UILabel!
    @IBOutlet weak var answerButton01: UIButton!
    @IBOutlet weak var answerButton02: UIButton!
    @IBOutlet weak var answerButton03: UIButton!
    @IBOutlet weak var answerButton04: UIButton!
    @IBOutlet weak var answerButton05: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scoreView: UIView!
    
    var quizWordUnit = QuizStruct(word: String(), wordFirst: String(), translation: String(), translationFirst: String(), details: String(), category: String(), shownAlready: Bool(), answeredRight: Bool())
    var quizWordList = [QuizStruct]()
    var currentQuestion = QuizStruct(word: String(), wordFirst: String(), translation: String(), translationFirst: String(), details: String(), category: String(), shownAlready: Bool(), answeredRight: Bool())
    var nativeLanguagePicked = true
    var multipleChoiceList = [QuizStruct]()
    
    //When quizWordList is created from the QuizEntry CoreData entity, we store the numbers of words already shown and how many
    //of these words shown where answered correctly
    var wordsShown = 0
    var rightAnswers = 0
    
    var delegate:QuizVCDelegate? = nil
    
    var answerButtonPushed = false
    var goBackMenuButton = UIBarButtonItem()
    
    var defaultButtonColor = UIColor(red: 203.0/255, green: 229.0/255, blue: 250.0/255, alpha: 1.0)
    var wrongButtonColor = UIColor(red: 248.0/255, green: 208.0/255, blue: 205.0/255, alpha: 1.0)
    var rightButtonColor = UIColor(red: 219.0/255, green: 248.0/255, blue: 199.0/255, alpha: 1.0)
    
    @IBAction func showNext(sender: UIButton) {

        var buttonList = [self.answerButton01, self.answerButton02, self.answerButton03, self.answerButton04, self.answerButton05]
        
        self.wordsShown += 1
        displayQuestion(wordsShown)
        self.nextButton.hidden = true
        self.answerButtonPushed = false
        //Reset all the buttons' background color to original color
        for i in buttonList {
            i.backgroundColor = self.defaultButtonColor
        }

//        println("wrongAnswerList is now \(self.multipleChoiceList.count)")
        
        //Looking at the shownAlready and answeredRight values of each word on the list
//        for i in self.multipleChoiceList {
//            println("\(i.word): shownAlready = \(i.shownAlready) and answeredRight: \(i.answeredRight)")
//        }
        
    }
    
    
    @IBAction func checkAnswer(sender: UIButton) {
        //checkAnswer() should only work once per turn. After an answer button has been pushed it should be de-activated
        //until the "Next" button is pushed
        if self.answerButtonPushed == false {
            self.answerButtonPushed = true
            var AnswerChosenOtherLanguage = String()
            var buttonList = [self.answerButton01, self.answerButton02, self.answerButton03, self.answerButton04, self.answerButton05]
            
            //Determine the word on the button pressed by the user
            if self.nativeLanguagePicked == true {
                for i in self.multipleChoiceList {
                    if i.translation == sender.titleLabel!.text! {
                        AnswerChosenOtherLanguage = i.word as String
                    }
                }
            } else {
                for i in self.multipleChoiceList {
                    if i.word == sender.titleLabel!.text! {
                        AnswerChosenOtherLanguage = i.translation as String
                    }
                }
            }
            
            println("AnswerChosenOtherLanguage is \(AnswerChosenOtherLanguage)")
            //if the button with the correct translation was chosen do the following
            if AnswerChosenOtherLanguage == self.wordLabel.text! {
                self.rightAnswers += 1
                self.correctAnswers.text = String(self.rightAnswers)
                self.quizWordList[self.wordsShown].answeredRight = true
                
                
            } else {
                sender.backgroundColor = self.wrongButtonColor
            }
            
            //Change the color of the button with the right answer to green
            if self.nativeLanguagePicked == true {
                for i in 0..<self.multipleChoiceList.count {
                    if self.multipleChoiceList[i].word == self.wordLabel.text! {
                        buttonList[i].backgroundColor = self.rightButtonColor
                        break
                    }
                }
            } else {
                for i in 0..<self.multipleChoiceList.count {
                    if self.multipleChoiceList[i].translation == self.wordLabel.text! {
                        buttonList[i].backgroundColor = self.rightButtonColor
                        break
                    }
                }
            }
            self.quizWordList[self.wordsShown].shownAlready = true
            var score = self.wordsShown + 1
            self.wordsDisplayed.text = String(score)
            println("checkAnswer() for \(self.quizWordList[self.wordsShown].word) answeredRight is:\(self.quizWordList[self.wordsShown].answeredRight) and shownAlready is:\(self.quizWordList[self.wordsShown].shownAlready)")
            saveAnswer(self.quizWordList[self.wordsShown])
            
            //When we've reached the last word of quizWordList, the "Next" button can not appear when the user choses an answer
            if self.wordsShown < self.quizWordList.count-1 {
                self.nextButton.hidden = false
                
            } else {
                presentCongratulationsVC()
                //Hide the score labels as they add to themselves when CongratulationsVC is dismissed
                self.scoreView.hidden = true
            }
        }
    }
    
    func saveAnswer(wordToSave: QuizStruct) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"QuizEntry")
        
        //3
        var error: NSError?
        
        var wordQuizzed = wordToSave.word as String
        var shownStatus = wordToSave.shownAlready as Bool
        var correctness = wordToSave.answeredRight as Bool
        
        println("QuizVC: saveAnswer() shownAlready for \(wordQuizzed) is \(shownStatus) and answeredRight is \(correctness) ")
        
        fetchRequest.predicate = NSPredicate(format: "word = %@", wordQuizzed)
        
        if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject] {
            if fetchedResults.count != 0 {
                var managedObject = fetchedResults[0]
                managedObject.setValue(shownStatus, forKey: "shownAlready")
                managedObject.setValue(correctness, forKey: "answeredRight")
                
                if managedContext.save(&error) {
                    println("saveAnswer() \(wordQuizzed) is updated")
                } else {
                    println("saveAnswer() could not save \(error)")
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        title = "List Selection"
        
        self.navigationItem.hidesBackButton = true
        
        //Create a back arrow on the nav bar
        var arrowbutton = UIButton.buttonWithType(.System)  as! UIButton
        var image = UIImage(named: "back_arrow.png")?.imageWithRenderingMode(.AlwaysTemplate)
        arrowbutton.setImage(image, forState: .Normal)
        //        custombutton.sizeToFit()
        arrowbutton.frame.size = CGSizeMake(10, 20)
        arrowbutton.frame.size = CGSizeMake(6, 21)
        var imageInsets = UIEdgeInsetsMake(0.0, -7.0, 0.0, 0.0)
        arrowbutton.imageEdgeInsets = imageInsets
        arrowbutton.addTarget(self, action: "goBackToMainMenu", forControlEvents:.TouchUpInside)
        var arrowBarButtonItem = UIBarButtonItem(customView: arrowbutton)
        
        
        self.goBackMenuButton = UIBarButtonItem(title: "Main Menu", style: .Plain , target: self, action: "goBackToMainMenu")
        self.goBackMenuButton.enabled = true
        self.navigationItem.setLeftBarButtonItems([arrowBarButtonItem, self.goBackMenuButton], animated: true)
    }
    
    func goBackToMainMenu() {
        self.navigationController?.popToRootViewControllerAnimated(true)
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
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            
            for word in results {
                self.quizWordUnit.word = word.valueForKey("word") as! String
                self.quizWordUnit.wordFirst = word.valueForKey("wordFirst") as! String
                self.quizWordUnit.translation = word.valueForKey("translation") as! String
                self.quizWordUnit.translationFirst = word.valueForKey("translationFirst") as! String
                self.quizWordUnit.details = word.valueForKey("details") as! String
                self.quizWordUnit.category = word.valueForKey("category") as! String
                self.quizWordUnit.answeredRight = word.valueForKey("answeredRight") as! Bool
                self.quizWordUnit.shownAlready = word.valueForKey("shownAlready") as! Bool
                
                self.quizWordList.append(quizWordUnit)
                
                //Increase the values of wordShown and rightAnswers, based on what's store in QuizEntry CoreData entity
                if self.quizWordUnit.shownAlready == true {
                    self.wordsShown += 1
                }
                if self.quizWordUnit.answeredRight == true {
                    self.rightAnswers += 1
                }
            }
            
            println("QuizVC: viewWillAppear() wordsShown is \(self.wordsShown)")
            
            
            //Calling displayQuestion() using wordsShown ensures the latest unanswered word is shown any time the view appears
            //However if we've reached the end of the array of questions (i.e. wordsShown = array count) 
            //then using wordShown means that displayQuestion() is looking for an index value that is greater than what's in the array 
            //of questions. If this is the case, we need to show wordsShown - 1 instead. 
            //We also need to disable the answer buttons otherwise the app will crash
            if self.wordsShown == self.quizWordList.count {
                println("QuizVC: viewWillAppear() showing last word only")
                displayQuestion(wordsShown - 1)
                self.answerButtonPushed = true
            } else {
                displayQuestion(wordsShown)
            }
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        
        //Since we're showing a new question, the "Next" button needs to be hidden until an answer has been provided
        self.nextButton.hidden = true
        
        //If we're showing the last word in the array of questions AND it has already been answered 
        //then
//        if self.wordsShown == self.quizWordList.count {
//            
//            println("QuizVC: viewWillAppear() showing last word only")
//        }
        

    }
    
    func displayQuestion(wordPosition: Int) {
        println("QuizVC: displayQuestion() called with wordPosition \(wordPosition) & quizWordList count is \(self.quizWordList.count)")
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
        
        self.currentQuestion.shownAlready = true
        self.wordsDisplayed.text = String(self.wordsShown)
        self.correctAnswers.text = String(self.rightAnswers)
        
        updateAnswerButtons()
    }
    
    
    func updateAnswerButtons() {
        var listOfWrongAnswers = randomWrongAnswers()
        self.multipleChoiceList = []
        
        //Random index at which to put the index of the right answer
        //Note: that index is wordsShown, unless we've reached the end of the array of questions, in which case it will be wordsShown - 1
        var rightAnswerPosition = randomNumberInRange(0, upper: 4)
        var indexOfQuizWord = Int()
        
        if self.wordsShown == self.quizWordList.count {
            indexOfQuizWord = self.wordsShown - 1
        } else {
            indexOfQuizWord = self.wordsShown
        }
        
        listOfWrongAnswers.insert(indexOfQuizWord, atIndex: rightAnswerPosition)
        
        for i in listOfWrongAnswers {
            self.multipleChoiceList.append(self.quizWordList[i])
        }
        
        println("QuizVC: updateAnswerButtons() listOfWrongAnswers is: \(listOfWrongAnswers)")
//        println("updateAnswerButtons() multipleChoiceList is: \(multipleChoiceList.count)")
        
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
    
    func presentCongratulationsVC() {
        println("QuizVC presentCongratulations() started")
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let congratsScreen = storyboard.instantiateViewControllerWithIdentifier("CongratsVC") as! CongratulationsVC
        congratsScreen.quizLength = self.wordsShown + 1
        congratsScreen.rightAnswers = self.rightAnswers
        
        congratsScreen.delegate = self
        self.presentViewController(congratsScreen, animated: true, completion: nil)
//        self.navigationController?.pushViewController(QuizScreen, animated: true)
    }
    
    func goToResults() {
        println("QuizVC: goToResults()")
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let resultsScreen = storyboard.instantiateViewControllerWithIdentifier("Results") as! ResultsVC
//        congratsScreen.quizLength = self.wordsShown + 1
//        congratsScreen.rightAnswers = self.rightAnswers
        
//        congratsScreen.delegate = self
//        self.presentViewController(resultsScreen, animated: true, completion: nil)
        self.navigationController?.pushViewController(resultsScreen, animated: true)
        
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
