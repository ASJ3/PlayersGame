//
//  SecondViewController.swift
//  TimingProject
//
//  Created by Alexis Saint-Jean on 1/30/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var allWeekBox: UIView!
    
    @IBOutlet weak var goalName: UITextField!

    @IBOutlet weak var picker: UIPickerView!
    
    // I want the minutes component in the UIPicker to look like it is an infinite loop
    // As a solution I create a really long array 'lotsOfMintues' which is going to be
    // multiples of the 'minutesArray'
    var minutesArray = ["00","05","10","15","20","25","30","35","40","45","50","55"]
    var lotsOfMinutes = [String] ()
    
    var goalTimeData = [ [" 0"," 1"," 2"," 3"," 4"," 5"," 6"," 7"," 8"," 9", "10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48"],["hours"],["min"]]


    
    // Function that ensures the keyboard disappear after the player enters 'Return'
    // on the pop-up keyboard when they are done entering their name
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // The following function is required as part of the
    // UIPickerViewDataSource. It indicates how many
    // 'components' (i.e. columns) are in the UIPickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView)->Int {
        
        return 4
    }
    
    // The following function is also required as part of the
    // UIPickerViewDataSource. It indicates how many
    // rows of data are in the UIPickerView
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return goalTimeData[component].count

    }
    
    // this method returns a plain NSString to display the row for each component.
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return goalTimeData[component][row]
    }
    
    // Set the width of each component on the UIPicker
    // components 1 and 3 (i.e. columns 2 and 4) only display
    // the 'hours' and 'min' labels and need more width
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component  % 2 == 0 {
            return 40
        }
        else { return 70 }
    }
    
    // Set the height of the UIPicker
    // A bigger number means more space between numbers of each column
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    // Catpure the picker view selection   
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println("the value from component \(self.goalTimeData[component].count) is \(self.goalTimeData[component][row])")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
////        self.allWeekBox.layer.borderColor = UIColor.blackColor().CGColor
//
//        
//        self.allWeekBox.layer.borderColor = UIColor.blueColor().CGColor
        
        
        self.goalName.delegate = self
        
        self.picker.dataSource = self
        self.picker.delegate = self
        
        // Here I add multiple copies of 'minutesArray' into the 'lotsOfMinutes' array
        for i in 0...99 {
            self.lotsOfMinutes += self.minutesArray
            println("\(self.lotsOfMinutes.count)")
        }
        
        // I then insert the 'lotsOfMinutes' array at the second-to-last position in
        // the 'goaltTimeData' array of arrays
        self.goalTimeData.insert(self.lotsOfMinutes, atIndex: self.goalTimeData.count-1)
        
        // Finally I select a row right in the middle of the minutes array of 'goalTimeData'
        // So it looks like minutes is an infinite loop
        self.picker.selectRow(self.goalTimeData[2].count / 2, inComponent: 2, animated: false)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns in the number picker

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
