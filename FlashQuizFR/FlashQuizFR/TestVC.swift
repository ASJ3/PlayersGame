//
//  TestVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 7/22/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//
//CoreData code based on tutorial from http://www.raywenderlich.com/85578/first-core-data-app-using-swift

import UIKit
import CoreData

class TestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var words = [NSManagedObject]()
    var nativeFirstArray = [String]()
    var uniqueNativeFirstArray = [AnyObject]()
    var stringResultsArray = [AnyObject]()
    var nativeWordList = [String: [AnyObject]]()
    var sortedNativeWordList = [AnyObject]()
    var wordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "gender":String(), "category":String()]
    var categoryFromList = ["category": String(), "wordCount": String()]

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "\"The List\""

        // Do any additional setup after loading the view.
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        
        let fetchRequest = NSFetchRequest(entityName:"WordEntry")
        
        //sortDescriptor is to enable us to sort the list of category alphabetically, to display it in the tableView
//        let sortDescriptor = NSSortDescriptor(key: "category", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let countExpression = NSExpression(format: "count:(wordFirst)")
        let countED = NSExpressionDescription()
        countED.expression = countExpression
        countED.name = "wordCount"
        countED.expressionResultType = .Integer32AttributeType
        
        fetchRequest.propertiesToFetch = ["category", countED]
        //Here we are indicating that the fetchRequest will be an array of dictionaries
        fetchRequest.resultType = .DictionaryResultType
        fetchRequest.propertiesToGroupBy = ["category"]
//        fetchRequest.returnsDistinctResults = true
        
        //3
        var error: NSError?
        
        if let results = managedContext.executeFetchRequest(fetchRequest,
            error: &error) {
//            words = results
            println("TestVC: count is \(results.count)")

                for i in 0...results.count-1 {
                    categoryFromList["category"] = results[i]["category"] as? String
                    
                    
                    if let intCount = results[i]["wordCount"]! as? Int {
                        categoryFromList["wordCount"] = String(intCount)
                    }
                    
                    println("TestVC: \(categoryFromList)")
                    self.stringResultsArray.append(categoryFromList)
                }
             println("TestVC: final array is \(self.stringResultsArray)")
                
            


        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
//            println("TestVC: there was an error")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    }
