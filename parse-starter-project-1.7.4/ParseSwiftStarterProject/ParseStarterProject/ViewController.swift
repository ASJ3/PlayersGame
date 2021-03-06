//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var personalStory: UITextView!
    @IBAction func getInfo(sender: AnyObject) {
        println("Trying to get the info")
        var infoQuery = PFQuery(className: "Whisper")
        infoQuery.whereKey("user", equalTo: self.firstName.text)
        
        infoQuery.findObjectsInBackgroundWithBlock {
            (object, error) -> Void in
            
            for info in object! {
                if let gender: AnyObject? = info["category"] {
                    self.gender.text = gender as! String
                }
                
                if let story: AnyObject? = info["whisper"] {
                    self.personalStory.text = story as! String
                }
            }
        }
    }
    
//    @IBAction func readWhispers(sender: AnyObject) {
//        var whisperQuery = PFQuery(className: "Whisper")
//        whisperQuery.whereKey("category", equalTo: self.whisperCat.text)
//        whisperQuery.findObjectsInBackgroundWithBlock { (whisperObjects: [AnyObject]!, error: NSError!) -> Void in
//            for whisper in whisperObjects {
//                //                println(whisper["whisper"])
//                if let whisperTitle: AnyObject? = whisper["whisper"] {
//                    println(whisperTitle)
//                }
//            }
//        }
    
    
    @IBAction func submitInfo(sender: AnyObject) {
        
        var whisperP = PFObject(className: "Whisper")
        whisperP["whisper"] = self.personalStory.text
        whisperP["user"] = self.firstName.text
        whisperP["category"] = self.gender.text
        whisperP.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if(success) {
                println(whisperP.objectId)
                println("Whisper saved succesfully")
            } else {
                println(error!.description)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            println("Object has been saved.")
//        }
        
        self.firstName.delegate = self;
        self.gender.delegate = self;
        self.personalStory.delegate = self;
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

