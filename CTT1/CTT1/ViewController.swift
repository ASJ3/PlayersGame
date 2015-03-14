//
//  ViewController.swift
//  CTT1
//
//  Created by Alexis Saint-Jean on 3/11/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tempData = ["I see God’s hand in everything around us including the whole universe. If it suited His purposes not just to have one planet that could sustain life that would give rise to intelligence, fine. I don’t see any reason to be shaken or object to that at all.",
        "The big bang is not a point in space. It’s a moment in time. It’s a moment when the density of the universe was infinite.",
        "One of the most important things which our minds undertake is to understand other human beings. We’ve become - we’ve evolved to be - what I call ‘natural psychologists’, who are brilliant at mind reading.",
        "Quote 4",
        "Quote 5",
        "Quote 6",
        "Quote 7",
        "Quote 8",
        "Quote 9",
        "Quote 10",
        "Quote 11",
        "Quote 12",
        "Quote 13",
        "Quote 14",
        "Quote 15", "Quote 16", "Quote 17", "Quote 18","Quote 19", "Quote 20" ]
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //For now uses the tempData array to create the number of cells needed
        return tempData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
            cell.textLabel?.text = tempData[indexPath.row]
        
        return cell
    }
    
    // When the user clicks on a cell, we want to switch to the quoteViewController and show the quote
    // To do that we need to pass to quoteViewController the info related to the quote clicked
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            var permalink = tempData[indexPath.row]
            self.performSegueWithIdentifier("showQuote", sender: permalink)
//            println("the quote is:\n\(permalink)")
        }
        
    
    // prepareForSegue is directly related to the tableView(...) function
    // here the 'sender' argument in the function is going to be the text info of the quote
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//            var destinationViewController = segue.destinationViewController as UIViewController
        println("running the prepareForSegue function")
        if let forsure = segue.destinationViewController as? quoteViewController {
            var text = sender as? NSString
            forsure.textOfQuote = text
        }
//            var text = sender as? NSString
//            destinationViewController.textOfQuote = text
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

