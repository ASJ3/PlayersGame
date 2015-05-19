//
//  SecondViewController.swift
//  PopKaltura
//
//  Created by Alexis Saint-Jean on 4/15/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var videoView: UIWebView!
    @IBAction func bottomButton(sender: UIButton) {
        println("bottomButton was clicked")
    }
    @IBAction func dismissButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This time I am using the URL of one of the CTT interviews to show that it loads an entire webpage, not just a video
        self.videoView.delegate = self
        if let url = NSURL(string: "https://cdnapisec.kaltura.com/p/243342/sp/24334200/embedIframeJs/uiconf_id/12905712/partner_id/243342?iframeembed=true&entry_id=1_sf5ovm7u") {
            let request = NSURLRequest(URL: url)
            self.videoView.loadRequest(request)
        }
        
        
        
        println("SecondViewController: finished viewDidLoad")
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
