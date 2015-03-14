//
//  videoViewController.swift
//  CTT1
//
//  Created by Alexis Saint-Jean on 3/14/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class videoViewController: ViewController {
    @IBAction func returnToQuoteVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = NSURL(string: "https://www.youtube.com/embed/HsMUbZDNlik") {
            let request = NSURLRequest(URL: url)
            self.webView.loadRequest(request)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
