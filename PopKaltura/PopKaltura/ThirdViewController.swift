//
//  ThirdViewController.swift
//  PopKaltura
//
//  Created by Alexis Saint-Jean on 4/16/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var videoView: UIWebView!
    @IBAction func dismissViewButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This time I am using the URL of one of the CTT interviews to show that it loads an entire webpage, not just a video
        self.videoView.delegate = self
        if let url = NSURL(string: "http://www.closertotruth.com/interviews/2490") {
            let request = NSURLRequest(URL: url)
            self.videoView.loadRequest(request)
        }
        
        
        
        println("ThirdViewController: finished viewDidLoad")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
