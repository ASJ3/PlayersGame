//
//  ViewController.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 7/18/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

