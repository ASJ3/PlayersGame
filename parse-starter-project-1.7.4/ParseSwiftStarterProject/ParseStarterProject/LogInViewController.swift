//
//  LogInViewController.swift
//  ParseStarterProject
//
//  Created by Alexis Saint-Jean on 6/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBAction func loggingIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(self.userName.text, password: self.userPassword.text) { (user, error) -> Void in
                if user != nil {
                    println("Log in successful")
                    self.performSegueWithIdentifier("showFirstUseScreen", sender: nil)
                } else {
                    println("Log in Error")
                }
        }
//        if self.userName.text == "Alexis" {
//            println("Correct user name")
//            
//        } else {
//            println("Incorrect user name")
//        }
    }
    
    @IBAction func Register(sender: AnyObject) {
        var user = PFUser()
        user.username = self.userName.text
        user.password = self.userPassword.text
        user.email = self.userName.text
        
        user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            if error == nil {
                self.userName.text = ""
                self.userPassword.text = ""
                self.performSegueWithIdentifier("showFirstUseScreen", sender: nil)
                println("Registration successful")
            } else {
                println("Couldn't register")
                println("\(error)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userName.delegate = self
        self.userPassword.delegate = self
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            println("you are logged in!")
            println(currentUser)
        } else  {
            println("Not logged in!")
        }
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
