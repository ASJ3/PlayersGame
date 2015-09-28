//
//  LanguageSelectionVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 8/3/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class LanguageSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var languagesArray = [["English", "French"], ["French", "English"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.alwaysBounceVertical = false
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languagesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("languageCell")!
        
        
        cell.textLabel!.text = self.languagesArray[indexPath.row][0]
        cell.detailTextLabel?.text = self.languagesArray[indexPath.row][1]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    //Function used to pass the language layout selected in the tableview (either English/French or French/English)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCategories" {
            if let destination = segue.destinationViewController as? DictListVC {
                if let tableIndex = tableView.indexPathForSelectedRow?.row {
                    destination.languageSelected = self.languagesArray[tableIndex][0]
                }
            }
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
