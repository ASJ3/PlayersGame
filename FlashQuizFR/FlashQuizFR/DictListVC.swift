//
//  DictListVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 8/1/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//
//CoreData code based on tutorial from http://www.raywenderlich.com/85578/first-core-data-app-using-swift
//Group by function in CoreData based on http://stackoverflow.com/questions/29562104/ios-swift-core-data-counting-child-entities

import UIKit
import CoreData

class DictListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var words = [AnyObject]()
    var stringResultsArray = [AnyObject]()
    var categoryFromList = ["category": String(), "wordCount": String()]
    var languageSelected = "English"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = "\"The List\""
        print("DictListVC: language selected is \(self.languageSelected)")
        loadCoreData()
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stringResultsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wordCell")!
        
        let categoryName = self.stringResultsArray[indexPath.row]["category"] as! String
        
        cell.textLabel!.text = categoryName
        cell.detailTextLabel?.text = self.stringResultsArray[indexPath.row]["wordCount"] as! String + " words"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        let categorySelected = self.stringResultsArray[row]["category"] as! String
        print("DictListVC: the category selected is: \(categorySelected)")
    }
    
    func loadCoreData() {
        print("DictListVC: inside loadCoreData()")
        
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
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
                words = results
                print("DictListVC: count of categories to add to stringsResultArray: \(words.count)")
                
                for i in 0...results.count-1 {
                    categoryFromList["category"] = words[i]["category"] as? String
                    
                    
                    if let intCount = words[i]["wordCount"]! as? Int {
                        categoryFromList["wordCount"] = String(intCount)
                    }
                    
                    self.stringResultsArray.append(categoryFromList)
                }
                
                print("DictListVC: stringsResultArray now has \(self.stringResultsArray.count) categories")
                print("DictListVC: stringsResultArray's first category is \(self.stringResultsArray[0])")
                
                
        } catch let error1 as NSError {
            error = error1
            print("Could not fetch \(error), \(error!.userInfo)")
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("DictListVC: ViewWillAppear(): stringsResultArray now has \(self.stringResultsArray.count) categories")
    
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowWordsInDictionary" {
            if let destination = segue.destinationViewController as? DictionaryVC {
                if let tableIndex = tableView.indexPathForSelectedRow?.row {
                    destination.filter = self.stringResultsArray[tableIndex]["category"] as! String
                    destination.languageUsed = self.languageSelected
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
