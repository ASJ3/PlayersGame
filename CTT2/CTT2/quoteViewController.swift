//
//  quoteViewController.swift
//  CTT2
//
//  Created by Alexis Saint-Jean on 3/16/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class quoteViewController: UIViewController {
    var textOfQuote: String?
    var authorOfQuote: String?
    var professionOfAuthor: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        println("Here is the Text: \(self.textOfQuote)\n\(self.authorOfQuote)\n\(self.professionOfAuthor)")
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
