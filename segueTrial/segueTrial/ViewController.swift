//
//  ViewController.swift
//  segueTrial
//
//  Created by Alexis Saint-Jean on 6/13/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func button(sender: AnyObject) {
        self.performSegueWithIdentifier("segue", sender: nil)
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

