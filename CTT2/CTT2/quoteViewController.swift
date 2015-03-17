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
    var terms: String?

    @IBOutlet weak var authorField: UILabel!
    @IBOutlet weak var termsField: UILabel!
    @IBOutlet weak var quoteField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.authorField.text = self.authorOfQuote
        self.termsField.text = self.terms
        self.quoteField.text = self.textOfQuote
//        
//        println("Here is the Text: \(self.textOfQuote)\n\(self.authorOfQuote)\n\(self.terms)")
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
