//
//  ViewController.swift
//  twoVCs
//
//  Created by Alexis Saint-Jean on 6/13/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textEntered: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        if segue.identifier == "showMain"
        //        {
        //            if let destinationVC = segue.destinationViewController as? ViewController {
        //                //                        destinationVC.numberToDisplay = counter
        //            }
        //        }
        
        if self.textEntered.text == "Alexis" {
            println("Can move to the next view")
        } else {
            println("Wrong name, cannont more to the next view")
        }
    }


}

