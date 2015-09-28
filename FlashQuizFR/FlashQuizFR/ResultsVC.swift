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
    var quizWordUnit = QuizStruct(word: String(), wordFirst: String(), translation: String(), translationFirst: String(), details: String(), category: String(), shownAlready: Bool(), answeredRight: Bool())
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
        let error: NSError?
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
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
                }
                print("ResultsVC: viewDidLoad() quizWordList is \(self.quizWordList.count)")
                
            }
            
            
        } catch let error1 as NSError {
            error = error1
            print("saveAnswer() could not save \(error)")
        }
        
        
//        else {
//            print("Could not fetch \(error), \(error!.userInfo)")
//        }
        
        title = "Results"
        
        self.navigationItem.hidesBackButton = true
        
        //Create a back arrow on the nav bar
        let arrowbutton = UIButton(type: .System)
        let image = UIImage(named: "back_arrow.png")?.imageWithRenderingMode(.AlwaysTemplate)
        arrowbutton.setImage(image, forState: .Normal)
        //        custombutton.sizeToFit()
        arrowbutton.frame.size = CGSizeMake(10, 20)
        arrowbutton.frame.size = CGSizeMake(6, 21)
        let imageInsets = UIEdgeInsetsMake(0.0, -7.0, 0.0, 0.0)
        arrowbutton.imageEdgeInsets = imageInsets
        arrowbutton.addTarget(self, action: "goBackToMainMenu", forControlEvents:.TouchUpInside)
        let arrowBarButtonItem = UIBarButtonItem(customView: arrowbutton)
        
        
        self.goBackMenuButton = UIBarButtonItem(title: "Main Menu", style: .Plain , target: self, action: "goBackToMainMenu")
        self.goBackMenuButton.enabled = true
        self.navigationItem.setLeftBarButtonItems([arrowBarButtonItem, self.goBackMenuButton], animated: true)
        
        emptyQuizList()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("wordCell")!
        
        let wordAnswer = self.quizWordList[indexPath.row].answeredRight
        let colorOfCell = cellColorPicker(wordAnswer)
        
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
    
    //Now that the results of the quiz are shown, the QuizEntry Core Data attribute needs to be emptied using emtyQuizList()
    //This way, the "continue quiz" button will disappear from ViewController
    func emptyQuizList() {
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
        
        for entity in fetchedResults {
            managedContext.deleteObject(entity)
        }
        do {
            try managedContext.save()
        } catch _ {
        }
        
        let fetchedResultsAfterDeletion =
        (try! managedContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
        
        print("ResultsVC: emptyQuizList() now number of words in fetchedResults is \(fetchedResultsAfterDeletion.count)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
