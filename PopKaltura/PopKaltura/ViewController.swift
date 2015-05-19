//
//  ViewController.swift
//  PopKaltura
//
//  Created by Alexis Saint-Jean on 4/15/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIWebViewDelegate {
    @IBAction func dismissButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // newView is intended as an example of a programmatically generated UIView to show what happens when it gets added as a subview to the main view on screen.
        // Its shade is a darker gray and it appears near the top of the screen
        var newView = UIView(frame: CGRectMake(15.0, 100.0, self.view.frame.width - 30.0, 15.0))
        newView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        self.view.addSubview(newView)
        
        

        // Trying to create the KalturaPlayer based on the Kaltura documentation
        var playerViewController = KPViewController()
        playerViewController.view.frame = CGRectMake(15.0, 50.0, 200.0, 120.0)
        // The text below appears in Xcode debug area, which shows that the Kaltura player is actually created (since we can print it width in the debug area)
        // However the player does not appear on screen
        println("the width of playerViewController is \(playerViewController.view.frame.width)")
        // Here below I set the URL of the video for the Kaltura Player. This address is for a video provided by Kaltura. Of course nothing happens because the Kaltura player does not appear on screen
        playerViewController.setWebViewURL("https://cdnapisec.kaltura.com/p/243342/sp/24334200/embedIframeJs/uiconf_id/12905712/partner_id/243342?iframeembed=true&entry_id=1_sf5ovm7u")
        self.view.addSubview(playerViewController.view!)
        
        
        
        // I am creating a UIWebview at the bottom of the screen to show what a video player looks like
        // Setting self as the delegate of the videoView webView and loading the URL with the video. The URL is the string between the " marks,
        self.videoView.delegate = self
        if let url = NSURL(string: "https://www.youtube.com/embed/5ZtRfACbygY") {
            let request = NSURLRequest(URL: url)
            self.videoView.loadRequest(request)
        }
        
        
        

        println("ViewController: finished viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var videoView: UIWebView!


}

