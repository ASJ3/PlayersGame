//
//  ViewController.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 7/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var status: UILabel!
    var wordListArray = NSMutableArray()
    var words = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TRIAL: figuring out which lists of words have been purchased/loaded to CoreData from wordListStatus plist
        var ListStatusPath = NSBundle.mainBundle().pathForResource("wordListStatus", ofType: "plist")
        var ListStatusArray = NSMutableArray(contentsOfFile: ListStatusPath!)!
        
        
        //If the "loaded" field of a list is true, then it means the words
        //in this list have been uploaded to CoreData.
        //If the field value is false, then we need to use wordDictionary plist
        //and upload the words from that list to CoreData
        if ListStatusArray[0].valueForKey("loaded") as? Bool == false {
            self.status.text = "list not yet loaded onto CoreData"
            
            //Loading all words and their translation from the wordDictionary plist
            var wordListPath = NSBundle.mainBundle().pathForResource("wordDictionary", ofType: "plist")
            wordListArray = NSMutableArray(contentsOfFile: wordListPath!)!
            
            println("ViewVC: count of words in wordListArray is \(wordListArray.count)")
            
            //Change the "loaded" status to true for the word list in wordListStatus plist
            ListStatusArray[0].setValue(true, forKey: "loaded")
            ListStatusArray.writeToFile(ListStatusPath!, atomically: true)
            
        } else {
            self.status.text = "list now loaded onto CoreData"
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

