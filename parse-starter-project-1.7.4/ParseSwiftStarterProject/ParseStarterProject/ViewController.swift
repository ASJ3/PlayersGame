//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            println("Object has been saved.")
//        }
        
       /* var whisperP = PFObject(className: "Whisper")
        whisperP["whisper"] = self.whisper.text
        whisperP["user"] = "Tedi"
        whisperP["category"] = self.whisperCat.text
        whisperP.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            if(success) {
                println(whisperP.objectId)
                println("Whisper saved succesfully")
                self.whisper.text = ""
                self.whisperCat.text = ""
            } else {
                println(error.description)
            }
        }
*/
        
        var whisperP = PFObject(className: "Whisper")
        whisperP["whisper"] = "Hello @ World!"
        whisperP["user"] = "Sylvia"
        whisperP["category"] = "Female"
        whisperP.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if(success) {
                println(whisperP.objectId)
                println("Whisper saved succesfully")
            } else {
                println(error!.description)
            }
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

