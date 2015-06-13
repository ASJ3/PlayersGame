//
//  LogInViewController.swift
//  ParseStarterProject
//
//  Created by Alexis Saint-Jean on 6/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBAction func loggingIn(sender: AnyObject) {
        if self.userName.text == "Alexis" {
            println("Correct user name")
            self.performSegueWithIdentifier("showFirstUseScreen", sender: nil)
        } else {
            println("Incorrect user name")
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userName.delegate = self
        self.userPassword.delegate = self
  
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showFirstUseScreen"
//        {
//            if let destinationVC = segue.destinationViewController as? ViewController {
//                //  do something here in the destination viewController
//            }
//        }
//    }

}
