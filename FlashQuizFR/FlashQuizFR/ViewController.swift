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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TRIAL: Loading all words and their translation from the defaultWordList plist
        var wordListPath = NSBundle.mainBundle().pathForResource("defaultWordList", ofType: "plist")
        var wordListArray = NSMutableArray(contentsOfFile: wordListPath!)
        
        //TRIAL: changing the text of the labels
        self.label1.text = wordListArray![0] as? String
        self.label2.text = wordListArray![1] as? String
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

