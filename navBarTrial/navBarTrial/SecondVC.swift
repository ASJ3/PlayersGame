//
//  SecondVC.swift
//  navBarTrial
//
//  Created by Alexis Saint-Jean on 9/19/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        //1
//        var goBackMenuButton = UIBarButtonItem(title: "Main Menu", style: .Plain , target: self, action: "goBackToMainMenu")
//        goBackMenuButton.enabled = true
//        self.navigationItem.setLeftBarButtonItem(goBackMenuButton, animated: true)
        
        
        //2
        var custombutton = UIButton.buttonWithType(.System)  as! UIButton
//        custombutton.setTitle("Menu", forState: .Normal)
        var image = UIImage(named: "back_arrow.png")?.imageWithRenderingMode(.AlwaysTemplate)
//        var image = UIImage(named: "back_arrow.png")
        custombutton.setImage(image, forState: .Normal)
//        custombutton.sizeToFit()
        custombutton.frame.size = CGSizeMake(6, 21)
        var imageInsets = UIEdgeInsetsMake(0.0, -7.0, 0.0, 0.0)
        custombutton.imageEdgeInsets = imageInsets
        custombutton.addTarget(self, action: "goBackToMainMenu", forControlEvents:.TouchUpInside)
        var customBarButtonItem = UIBarButtonItem(customView: custombutton)

//        var customBarButtonItem = UIBarButtonItem(image: "back_arrow.png", style: .Plain, target: self, action: "goBackToMainMenu")
//        self.navigationItem.leftBarButtonItem = customBarButtonItem
//        self.navigationItem.setLeftBarButtonItem(customBarButtonItem, animated: true)

//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"info.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//            style:UIBarButtonItemStylePlain
//            target:self
//            action:@selector(info:)]
        
        

        //3
        // 1
        var backArrowButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Main Menu", style: .Plain, target: self, action: "goBackToMainMenu")
//        self.navigationItem.setLeftBarButtonItem(backArrowButtonItem, animated: true)
//        // 2
//        var leftTextButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "goBackToMainMenu")
//        // 3
        self.navigationItem.setLeftBarButtonItems([customBarButtonItem,backArrowButtonItem], animated: true)
//
//        // Do any additional setup after loading the view, typically from a nib.
        
        
        var bodyButton = UIButton.buttonWithType(.System) as! UIButton
        bodyButton.setTitle("Main Menu", forState: .Normal)
        bodyButton.frame.origin.x = 100.0
        bodyButton.frame.origin.y = 100.0
        bodyButton.sizeToFit()
        self.view.addSubview(bodyButton)
        
    }
    
    func goBackToMainMenu() {
        self.navigationController?.popViewControllerAnimated(true)
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
