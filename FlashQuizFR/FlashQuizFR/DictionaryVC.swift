//
//  DictionaryVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 7/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class DictionaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    //TRIAL: creating an array of words for the table content
    var wordArray = ["avion","bateau","camion","train","ferry","helicoptere"]
    var wordListArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TRIAL: Loading all words and their translation from the wordDictionary plist
        var wordListPath = NSBundle.mainBundle().pathForResource("wordDictionary", ofType: "plist")
        wordListArray = NSMutableArray(contentsOfFile: wordListPath!)!
        
        //TRIAL: try to get the number of sections in English based on the number of unique first letters we have in wordDictionary
        var firstLetterArray: [String:Int] = ["a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0, "h":0, "i": 0, "j": 0, "k": 0, "l": 0, "m": 0, "n": 0, "o": 0, "p": 0, "q": 0, "r": 0, "s": 0, "t": 0, "u": 0, "v": 0, "w": 0, "x": 0, "y": 0, "z": 0]

        //Increase the count of the values in firsLetterArray based on the number of times each letter appears as the first letter in each word of wordDictionary
        for word in wordListArray {
            var firstChar = word["wordFirst"] as! String
            firstLetterArray[firstChar]! += 1
            
            }
        
        println("DictionaryVC: \(firstLetterArray)")

        
        self.table.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordListArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("wordCell") as! UITableViewCell!
        if cell == nil  {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "wordCell")
        }
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.backgroundColor = UIColor.clearColor()
        
        //Note: we are using the objectForKey because the plist is an array of dictionaries, and we want
        //to retrieve certain parts of these dictionaries, and objectForKey is the way to to this for dictionaries in plists.
        cell.textLabel?.text = wordListArray[indexPath.row].objectForKey("word") as? String
        var wordGender = wordListArray[indexPath.row].objectForKey("gender") as! String
        cell.detailTextLabel?.text = wordListArray[indexPath.row].objectForKey("translation") as! String + " (" + wordGender + ")"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
