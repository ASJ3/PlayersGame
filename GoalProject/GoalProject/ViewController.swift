//
//  ViewController.swift
//  GoalProject
//
//  Created by Alexis Saint-Jean on 2/10/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var goals = [NSManagedObject]()
    
    @IBAction func addNewGoal(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("secondVC") as SecondViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    
    // Function that ensures the keyboard disappear after the player enters 'Return'
    // on the pop-up keyboard when they are done entering their name
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.goals.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let goal = self.goals[indexPath.row]
        cell.textLabel?.text = goal.valueForKey("name") as String?
        // Configure the cell...
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Add self as the delegate to a bunch of textfields
        // to make sure the keyboard disappear when entering "Return"
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

