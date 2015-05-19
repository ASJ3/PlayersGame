//
//  ViewController.swift
//  VideoViewTrial
//
//  Created by Alexis Saint-Jean on 4/30/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var videoView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
         self.videoView.delegate = self
        
        var videoWidth = String(Int(self.view.bounds.width - 60))
        var videoHeight = String(Int((self.view.bounds.width - 60) / 4 * 3))
        
        var myHTML = "<div id='kaltura_player_1430180256' style='width: " +  videoWidth + "px; height: " + videoHeight + "px;' itemprop='video' itemscope itemtype='http://schema.org/VideoObject'> <span itemprop='name' content='quote-app'></span> <span itemprop='description' content=''></span> <span itemprop='duration' content=''></span> <span itemprop='thumbnail' content='http://cdnbakmi.kaltura.com/p/1529571/sp/152957100/thumbnail/entry_id/0_92j4rrhi/version/100000/acv/152'></span> <span itemprop='width' content='" + videoWidth + "'></span> <span itemprop='height' content='" + videoHeight + "'></span> </div> <script src='http://cdnapi.kaltura.com/p/1529571/sp/152957100/embedIframeJs/uiconf_id/29372971/partner_id/1529571?autoembed=true&entry_id=0_92j4rrhi&playerId=kaltura_player_1430180256&cache_st=1430180256&width=" + videoWidth +  "&height=" + videoHeight + "'></script>"
        
                self.videoView.loadHTMLString(myHTML, baseURL: nil)
        
        var sizeOfWidth = self.view.bounds.width
        
        println("the current width of the screen is: \(sizeOfWidth)")
        println("the current width of the video is: \(videoWidth)")
        println("the current height of the video is: \(videoHeight)")
        
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        println("the video has finished loading")
//        self.loadingVideoIndicator.stopAnimating()
//        self.loadingVideoIndicator.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

