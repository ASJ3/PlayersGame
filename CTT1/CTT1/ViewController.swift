//
//  ViewController.swift
//  CTT1
//
//  Created by Alexis Saint-Jean on 3/11/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var firstTimeLoading = true
    var json: NSArray?

    
    var midtempData = [["quote": "I see God’s hand in everything around us including the whole universe. If it suited His purposes not just to have one planet that could sustain life that would give rise to intelligence, fine. I don't see any reason to be shaken or object to that at all", "contributor_name": "Francis Collins", "Profession": "Geneticist"],
        ["quote": "The big bang is not a point in space. It’s a moment in time. It’s a moment when the density of the universe was infinite.", "contributor_name": "Sean Carroll", "Profession": "Physicist"],
        ["quote": "One of the most important things which our minds undertake is to understand other human beings. We’ve become - we’ve evolved to be - what I call ‘natural psychologists’, who are brilliant at mind reading.", "contributor_name": "Nicholas Humphrey", "Profession": "Psychologist"],
        ["quote": "Is it possible that this idea of God is something more than merely a functional idea. Could it be that under this world as we find it, there is some sort of deeper reality.", "contributor_name": "Philip Clayton", "Profession": "Philosopher"],
        ["quote": "It is remarkable that the complexity of our world can be explained in terms of simple physical laws and that these laws, which we can study in a lab, apply in the remotest galaxies.", "contributor_name": "Martin Rees", "Profession": "Astronomer"],
        ["quote": "I see God’s hand in everything around us including the whole universe. If it suited His purposes not just to have one planet that could sustain life that would give rise to intelligence, fine. I don't see any reason to be shaken or object to that at all", "contributor_name": "Francis Collins", "Profession": "Geneticist"]]

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //For now uses the tempData array to create the number of cells needed
        return midtempData.count
//        if let jsonData = self.json {
//            println(self.json!.count)
////            return self.json!.count
//            return 3
//
//        }
//        println("jsonData hasn't loaded yet")
//        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
            cell.textLabel?.text = midtempData[indexPath.row]["quote"]
        
        return cell
    }
    
    // When the user clicks on a cell, we want to switch to the quoteViewController and show the quote
    // To do that we need to pass to quoteViewController the info related to the quote clicked
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            var permalink = midtempData[indexPath.row]
            self.performSegueWithIdentifier("showQuote", sender: permalink)
            println("the quote is:\n\(permalink)")
        }
        
    
    // prepareForSegue is directly related to the tableView(...) function
    // here the 'sender' argument in the function is going to be the text info of the quote
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//            var destinationViewController = segue.destinationViewController as UIViewController
        println("running the prepareForSegue function")
        if let forsure = segue.destinationViewController as? quoteViewController {
            
            // **********
            // I'm having issues with setting the text variable to the "quote" of the sender (is it because it is an AnyObject?)
            // So first I am setting a local variable, localdictionary, then I am assigning the sender to it
            var localdictionary = ["quote": "", "contributor_name": "", "Profession": ""]
            localdictionary = sender as Dictionary
//            var text = sender["quote"] as? NSString
            var text = localdictionary["quote"]
            forsure.textOfQuote = text
            var authorName = localdictionary["contributor_name"]
            forsure.authorOfQuote = authorName
            var profession = localdictionary["Profession"]
            forsure.professionOfAuthor = profession
        }
//            var text = sender as? NSString
//            destinationViewController.textOfQuote = text
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("beginning of viewDidLoad")
        
        // working on loading JSON
        if let url = NSURL(string: "https://raw.githubusercontent.com/ASJ3/PlayersGame/master/API_JSON/all-quotes.json") {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                if let jsonDict: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) {
                    self.json = jsonDict as? NSArray
                    println("json count is now \(self.json!.count)")
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    // IMPORTANT we need to reload the data we got into our table view
//                    self.tableView.reloadData()
                })
            })
            task.resume()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

