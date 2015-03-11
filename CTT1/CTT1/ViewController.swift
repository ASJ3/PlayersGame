//
//  ViewController.swift
//  CTT1
//
//  Created by Alexis Saint-Jean on 3/11/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tempData = ["Quote 1", "Quote 2", "Quote 3","Quote 4", "Quote 5","Quote 6", "Quote 7", "Quote 8","Quote 9", "Quote 10","Quote 11", "Quote 12", "Quote 13","Quote 14", "Quote 15", "Quote 16", "Quote 17", "Quote 18","Quote 19", "Quote 20" ]
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //For now uses the tempData array to create the number of cells needed
        return tempData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if cell == nil  {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
            cell.textLabel?.text = tempData[indexPath.row]
        
        //        cell.textLabel?.text = self.tempData[indexPath.row]
        return cell
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

