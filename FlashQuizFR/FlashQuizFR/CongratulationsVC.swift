//
//  CongratulationsVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 9/11/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class CongratulationsVC: UIViewController {
    var quizLength = Int()
    var rightAnswers = Int()
    var pepTalkList = [". Don’t be discouraged! Keep practicing and you’ll get better at it.", "! Keep practicing and you’ll increase your score!", "! You’re halfway there!", "! You’re getting close to perfection!", "! Awesome!!"]
    var pepTalkIntro = "You've correctly answered "
    var pepTalkEnding = ""
    var gradient = CAGradientLayer()
    var bottomColor = UIColor(red: 141.0/255.0, green: 195.0/255/0, blue: 238.0/255.0, alpha: 1.0).CGColor as CGColorRef
    var topColor = UIColor(red: 229.0/255.0, green: 241.0/255/0, blue: 250.0/255.0, alpha: 0.5).CGColor as CGColorRef
    
    @IBOutlet var mainView: UIView!
    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var bannerText: UILabel!
    @IBOutlet weak var textBox: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gradient.frame = self.mainView.bounds
        self.gradient.colors = [UIColor.whiteColor().CGColor,self.topColor, self.bottomColor]
        self.gradient.locations = [0.0, 0.75, 1.0]
//        self.mainView.layer.insertSublayer(self.gradient, atIndex: 0)
        
        println("CongratsVC: viewDidLoad() points: \(self.rightAnswers) length: \(self.quizLength)")
        
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
