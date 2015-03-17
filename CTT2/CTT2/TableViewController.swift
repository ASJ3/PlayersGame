//
//  TableViewController.swift
//  CTT2
//
//  Created by Alexis Saint-Jean on 3/16/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var firstTimeLoading = true
    var json: NSArray?
    
    var failedToLoadData = [["quote_text": "Problems Fetching Quotes. Please try later", "contributor_name": "Author Name", "term_names": ""]]
    
    
    var midtempData = [["quote_text": "I see God’s hand in everything around us including the whole universe. If it suited His purposes not just to have one planet that could sustain life that would give rise to intelligence, fine. I don't see any reason to be shaken or object to that at all", "contributor_name": "Francis Collins", "term_names": "Geneticist"],
        ["quote_text": "The big bang is not a point in space. It’s a moment in time. It’s a moment when the density of the universe was infinite.", "contributor_name": "Sean Carroll", "term_names": "Physicist"],
        ["quote_text": "One of the most important things which our minds undertake is to understand other human beings. We’ve become - we’ve evolved to be - what I call ‘natural psychologists’, who are brilliant at mind reading.", "contributor_name": "Nicholas Humphrey", "term_names": "Psychologist"],
        ["quote_text": "Is it possible that this idea of God is something more than merely a functional idea. Could it be that under this world as we find it, there is some sort of deeper reality.", "contributor_name": "Philip Clayton", "term_names": "Philosopher"],
        ["quote_text": "It is remarkable that the complexity of our world can be explained in terms of simple physical laws and that these laws, which we can study in a lab, apply in the remotest galaxies.", "contributor_name": "Martin Rees", "term_names": "Astronomer"],
        ["quote_text": "I see God’s hand in everything around us including the whole universe. If it suited His purposes not just to have one planet that could sustain life that would give rise to intelligence, fine. I don't see any reason to be shaken or object to that at all", "contributor_name": "Francis Collins", "term_names": "Geneticist"]]
        
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
                        self.tableView.reloadData()
                    })
                })
                task.resume()
            }
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // Return the number of sections.
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Return the number of rows in the section.
//            return midtempData.count
            if let jsonData = self.json {
                return self.json!.count

            }
//            println("jsonData hasn't loaded yet")
            return 0
        }
        

        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
            if cell == nil  {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            }
            
            if let jsonData = self.json {
                if let quote = jsonData[indexPath.row] as? NSDictionary {
                    let articleTitle = quote["quote_text"] as NSString
                    cell.textLabel?.text = articleTitle
                }
            }
        
//            cell.textLabel?.text = midtempData[indexPath.row]["quote"]
        
        return cell
        }
    
    // When the user clicks on a cell, we want to switch to the quoteViewController and show the quote
    // To do that we need to pass to quoteViewController the info related to the quote clicked
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var permalink = midtempData[indexPath.row]
        if let jsonData = self.json {
            if let quote = jsonData[indexPath.row] as? NSDictionary {
                var permalink = quote
                println("the quote is:\n\(permalink)")
                self.performSegueWithIdentifier("showQuote", sender: permalink)
            }
        }
//        var permalink = midtempData[indexPath.row]
        

    }
    
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if let forsure = segue.destinationViewController as? quoteViewController {
                var localdictionary = ["quote_text": "", "contributor_name": "", "term_names": ""]
                
                localdictionary = sender as Dictionary
                var text = localdictionary["quote_text"]
                forsure.textOfQuote = text
                var authorName = localdictionary["contributor_name"]
                forsure.authorOfQuote = authorName
                var terms = localdictionary["term_names"]
                forsure.terms = terms
            }
            
        }

        
}
