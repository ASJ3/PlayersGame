//
//  ViewController.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 7/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //TRIAL: labels to ensure data loads properly
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TRIAL: Loading all words and their translation from the defaultWordList plist
        var wordListPath = NSBundle.mainBundle().pathForResource("defaultWordList", ofType: "plist")
        var wordListArray = NSMutableArray(contentsOfFile: wordListPath!)
        
        //TRIAL: changing the text of the labels
        self.label1.text = wordListArray![0] as? String
        self.label2.text = wordListArray![1] as? String
        
        //TRIAL: figuring out which lists of words have been purchased/loaded to CoreData from wordListStatus plist
        var ListStatusPath = NSBundle.mainBundle().pathForResource("wordListStatus", ofType: "plist")
        var ListStatusArray = NSMutableArray(contentsOfFile: ListStatusPath!)!
        
        
        if ListStatusArray[0].valueForKey("loaded") as? Bool == false {
            println("ViewController: list not yet loaded into CoreData")
            self.status.text = "list not yet loaded onto CoreData"

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

