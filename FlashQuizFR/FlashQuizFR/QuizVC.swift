//
//  QuizVC.swift
//  FlashQuizFR
//
//  Created by Alexis Saint-Jean on 8/12/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import CoreData

class QuizVC: UIViewController {
    @IBOutlet weak var wordLabel: UILabel!
    var wordsShown = 0
    
    
    var words = [NSManagedObject]()
    var filter = [String]()
    var nativeFirstArray = [String]()
    var uniqueNativeFirstArray = [String]()
    var nativeWordList = [String: [AnyObject]]()
    var sortedNativeWordList = [AnyObject]()
    var wordFromList = ["word":String(),  "wordFirst":String(), "translation":String(), "translationFirst":String(), "gender":String(), "category":String()]
    
    var stringResultsArray = [AnyObject]()
    var categoryFromList = ["category": String(), "wordCount": String()]
    

    @IBAction func closeVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"QuizEntry")
        
//        //Create a sortDescriptor to order the words in the list alphabetically
//        let sortDescriptor = NSSortDescriptor(key: self.titleSource, ascending: true, selector: "localizedCaseInsensitiveCompare:")
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        //Create a filter to only return the words of the selected category, defined in "filter"
//        
//        let predicate = NSPredicate(format: "category == %@", filter)
//        fetchRequest.predicate = predicate
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            words = results
            
            for word in words {
                var shownWord = word.valueForKey("quizzedWord") as! String
                if shownWord == "No" {
                    self.wordLabel.text = word.valueForKey("word") as? String
                    break
                } else {
                    self.wordsShown += 1
                }
               //var nativeWord = word.valueForKey("") as! String 
//                //Finding the number of times each letter appears as first letter in the native language. This is to help us create the lettered sections in the table
//                var nativeFirstLetter = word.valueForKey(self.titleFirst) as! String
//                self.nativeFirstArray.append(nativeFirstLetter)
//                
//                wordFromList["word"] = word.valueForKey(self.titleSource) as? String
//                wordFromList["wordFirst"] = word.valueForKey(self.titleFirst) as? String
//                wordFromList["translation"] = word.valueForKey(self.subtitleSource) as? String
//                wordFromList["translationFirst"] = word.valueForKey(self.subtitleFirst) as? String
//                wordFromList["gender"] = word.valueForKey("gender") as? String
//                wordFromList["category"] = word.valueForKey("category") as? String
//                
//                //Append "word" to the array in the corresponding dictionary in nativeWordlist
//                if self.nativeWordList[nativeFirstLetter] == nil {
//                    self.nativeWordList[nativeFirstLetter] = [wordFromList]
//                } else {
//                    self.nativeWordList[nativeFirstLetter]!.append(wordFromList)
//                }
//                
            }
            
            //Create a sorted array listing each unique letter
            uniqueNativeFirstArray = Array(Set(self.nativeFirstArray))
            uniqueNativeFirstArray.sort(){$0 <  $1}
            println("DictionaryVC: uniqueNativeFirstArray is : \(uniqueNativeFirstArray)")
            
            for i in uniqueNativeFirstArray {
                var wordArrayForLetter = self.nativeWordList[i]
                self.sortedNativeWordList.append(wordArrayForLetter!)
            }
            
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
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
