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
    var goBackMenuButton = UIBarButtonItem()

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
            }
            println("ResultsVC: viewDidLoad() quizWordList is \(self.quizWordList.count)")
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        title = "Results"
        
        self.navigationItem.hidesBackButton = true
        self.goBackMenuButton = UIBarButtonItem(title: "Main Menu", style: .Plain , target: self, action: "goBackToMainMenu")
        self.goBackMenuButton.enabled = true
        self.navigationItem.setLeftBarButtonItem(goBackMenuButton, animated: true)
    }
    
    func goBackToMainMenu() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quizWordList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wordCell") as! UITableViewCell
        
        var wordAnswer = self.quizWordList[indexPath.row].answeredRight
        var colorOfCell = cellColorPicker(wordAnswer)
        
        cell.backgroundColor = colorOfCell
        
        cell.textLabel!.text = self.quizWordList[indexPath.row].word
        cell.detailTextLabel?.text = self.quizWordList[indexPath.row].translation
        
        return cell
    }
    
    
    //cellColorPicker() indicate what background color a given cell in the table should have
    //based on whether the word was answered right in the quiz
    func cellColorPicker(answeredRight: Bool) -> UIColor {
        var colorToReturn = UIColor()
        
        if answeredRight == false {
            colorToReturn = UIColor(red: 248.0/255.0, green: 208.0/255.0, blue: 205.0/255.0, alpha: 1.0)
        } else if answeredRight == true {
            colorToReturn = UIColor(red: 219.0/255.0, green: 248.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        } else {
            colorToReturn = UIColor.clearColor()
        }
        return colorToReturn
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
