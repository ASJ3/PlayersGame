//
//  CongratulationsVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 9/11/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class CongratulationsVC: UIViewController {
    var gradient = CAGradientLayer()
    //    var bottomColor = UIColor(red: 248.0/255.0, green: 244.0/255/0, blue: 120.0/255.0, alpha: 1.0).CGColor as CGColorRef
    var bottomColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 219.0/255.0, alpha: 1.0).CGColor as CGColorRef
    //       var bottomColor = UIColor(red: 215.0/255.0, green: 226.0/255/0, blue: 235.0/255.0, alpha: 1.0).CGColor as CGColorRef
    var topColor = UIColor(red: 251.0/255.0, green: 251.0/255.0, blue: 242.0/255.0, alpha: 0.5).CGColor as CGColorRef
    
    var quizLength = Int()
    var rightAnswers = Int()
    var pepTalkList = [". Don’t be discouraged! Keep practicing and you’ll get better at it.", "! Keep practicing and you’ll increase your score!", "! You’re halfway there!", "! You’re getting close to perfection!", "! Awesome!!"]
    var pepTalkIntro = "You've correctly answered "
    var pepTalkEnding = ""
    
    @IBOutlet var mainView: UIView!
    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var bannerText: UILabel!
    @IBOutlet weak var textBox: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        println("CongratsVC: viewDidLoad() points: \(self.rightAnswers) length: \(self.quizLength)")
        
        self.gradient.frame = self.mainView.bounds
        //UIColor.whiteColor().CGColor
        self.gradient.colors = [self.topColor, self.bottomColor]
        self.gradient.locations = [0.5, 0.9]
        self.mainView.layer.insertSublayer(self.gradient, atIndex: 0)
        
        switch self.rightAnswers {
        case 0...4:
            self.bannerText.text = "Keep Going!"
            self.pepTalkEnding = self.pepTalkList[0]
        case 5...9:
            self.pepTalkEnding = self.pepTalkList[1]
        case 10:
            self.pepTalkEnding = self.pepTalkList[2]
        case 11...19:
            self.pepTalkEnding = self.pepTalkList[3]
        case 20:
            self.pepTalkEnding = self.pepTalkList[4]
        default:
            self.pepTalkEnding = "."
        }
        
        var textIntro = self.pepTalkIntro + String(self.rightAnswers) + " out of " + String(self.quizLength) + " words"
        
        self.textBox.text = textIntro + self.pepTalkEnding
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
