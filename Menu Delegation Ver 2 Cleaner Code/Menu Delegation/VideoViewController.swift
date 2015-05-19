//
//  VideoViewController.swift
//  Menu Delegation
//
//  Created by Dave Scherler on 3/22/15.
//  Copyright (c) 2015 DaveScherler. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UIWebViewDelegate {
    
    // Variable to use in the appDelegate file to help with screen Orientation restrictions
    var isPresented: Bool?
    var urlstring = "https://www.youtube.com/embed/5ZtRfACbygY"
    
//    var urlstring = "https://cdnapisec.kaltura.com/p/243342/sp/24334200/embedIframeJs/uiconf_id/12905712/partner_id/243342?iframeembed=true&entry_id=1_sf5ovm7u"

    @IBOutlet weak var videoView: UIWebView!
    @IBOutlet weak var videoTitle: UILabel!
    
    @IBAction func dismissVideoVC(sender: UIButton!) {
        isPresented = false
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var loadingVideoIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoView.delegate = self
        self.isPresented = true
        //update this URL based on selection. 
        if let url = NSURL(string: self.urlstring) {
            let request = NSURLRequest(URL: url)
            self.videoView.loadRequest(request)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        println("the video has finished loading")
        self.loadingVideoIndicator.stopAnimating()
        self.loadingVideoIndicator.hidden = true
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
