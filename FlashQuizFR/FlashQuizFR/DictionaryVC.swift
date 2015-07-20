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
    var wordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "gender":String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TRIAL: Loading all words and their translation from the wordDictionary plist
        var wordListPath = NSBundle.mainBundle().pathForResource("wordDictionary", ofType: "plist")
        wordListArray = NSMutableArray(contentsOfFile: wordListPath!)!
        
        //TRIAL: try to get the number of sections in the native language based on the number of unique first letters we have in wordDictionary
        //firstNativeLetterArray is an Array that indicates how many times each first letter of the alphabet appears in the wordDictionary plist
        var firstNativeLetterArray = [String:Int]()
        var nativeWordList = [String:AnyObject]()

        //Increase the count of the values in firsLetterArray based on the number of times each letter appears as the first letter in each word of wordDictionary
        for word in wordListArray {
            var firstChar = word["wordFirst"] as! String
            //Increase letter count in firsLetterArray, based on the first letter of the word
            if firstNativeLetterArray[firstChar] == nil {
                firstNativeLetterArray[firstChar] = 1
            } else {
               firstNativeLetterArray[firstChar]! += 1
            }
            
            }
        
        println("DictionaryVC: \(firstNativeLetterArray)")
        println("DictionaryVC: \(firstNativeLetterArray.count)")

        
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
