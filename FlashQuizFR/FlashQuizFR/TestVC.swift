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

    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "\"The List\""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return words.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        let person = words[indexPath.row]
        cell.textLabel!.text = person.valueForKey("word") as? String
        var wordGender = person.valueForKey("gender") as! String
         cell.detailTextLabel?.text = person.valueForKey("translation") as! String + " (" + wordGender + ")"
        
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
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            words = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    }
