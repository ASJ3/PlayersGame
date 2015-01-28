//
//  IntroViewController.swift
//  WizardGame
//
//  Created by Alexis Saint-Jean on 1/28/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var rulesBox: UIView!
    @IBAction func clickToRulesVC(sender: AnyObject) {
        goToRules()
    }

    @IBAction func goToPlaySection(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func goToRules() {
        println("you tapped")
        var progRulesVC = self.storyboard?.instantiateViewControllerWithIdentifier("rulesVC") as RulesViewController
        self.presentViewController(progRulesVC, animated: true , completion: nil)
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
