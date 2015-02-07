//
//  SecondViewController.swift
//  TimingProject
//
//  Created by Alexis Saint-Jean on 1/30/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    // Creates outlets for the day 'boxes' at the bottom of the screen
    // Also creates outlets for the checkboxes inside each 'day box'
    @IBOutlet weak var allWeekBox: UIView!
    @IBOutlet weak var allWeekCheckbox: UIView!
    @IBOutlet weak var mondayBox: UIView!
    @IBOutlet weak var mondayCheckbox: UIView!
    @IBOutlet weak var tuesdayBox: UIView!
    @IBOutlet weak var tuesdayCheckbox: UIView!
    @IBOutlet weak var wednesdayBox: UIView!
    @IBOutlet weak var wednesdayCheckbox: UIView!
    @IBOutlet weak var thursdayBox: UIView!
    @IBOutlet weak var thursdayCheckbox: UIView!
    @IBOutlet weak var fridayBox: UIView!
    @IBOutlet weak var fridayCheckbox: UIView!
    @IBOutlet weak var saturdayBox: UIView!
    @IBOutlet weak var saturdayCheckbox: UIView!
    @IBOutlet weak var sundayBox: UIView!
    @IBOutlet weak var sundayCheckbox: UIView!
    @IBAction func saveButton(sender: AnyObject) {
        if self.goalName.text.isEmpty {
            // If a goal name was not entered the goal cannot be saved and an alertView will inform the user
            var alertMessage = "The goal cannot be saved because no name was given to it. Please go back and give a name to your goal."
            let alert = UIAlertView(title: "Goal name missing!", message: alertMessage, delegate: nil, cancelButtonTitle: "Go Back")
            alert.show() }
        else {
            // Will instantiate an object of the Goal class to store all the info about the goal we're about to make.
            // But first we need to check whether the number of goal hours entered was for an entire week (i.e. goalSetPerWeek = true) or for a day.
            // If it's for a week, then just need to pass the total number of hours + minutes to the new object.
            // If it's for a day then we need to figure out how many days were checked, then multiply the number of hours + minutes entered in the UIPicker by the number of days selected
            var totalGoalTime = 0
            if goalSetPerWeek == false {
                // If boxesChecked = 8 then it means all the days of the week are selected
                // so we need to multiply the time set in the UIPicker by 7
                if boxesChecked == 8 {
                    totalGoalTime = (self.hoursChosen * 60 + self.minutesChosen) * 7
                } else {
                    totalGoalTime = (self.hoursChosen * 60 + self.minutesChosen) * boxesChecked
                }
                
            }
            else {
                // If goalSetPerWeek is true then we just need to add hours + time
                totalGoalTime = self.hoursChosen * 60 + self.minutesChosen
            }
            // Instantiate the object with the totalGoalTime we just calculated
            var currentGoal = Goal(goalName: self.goalName.text, goalDays: self.checkBoxState, goalMinutes:  totalGoalTime)
    
            println(currentGoal.description())
            println(currentGoal.goalDays)
        }
    }
    
    @IBOutlet weak var hoursAndMinutesPicker: UIPickerView!
    
    // Create two variables, hourChosen and minutesChosen, which will store the Int values chosen in the picker
    // (the picker actually contains strings showing numbers, but we can convert them to Int)
    var hoursChosen = 0
    var minutesChosen = 0
    
    // Create a goalSetPerWeek Bool variable that will show whether the "per week/per Day" 
    // UISegmentedControl is set on the "week" settings (i.e. true) or the "day" settings (false)
    var goalSetPerWeek = true
    
    // The weekDaySelect function is to ensure that the 'right' number of hours is displayed in the Hours component of the UIPicker
    // When the segmented control is set to 'Week' (default) then there should be a number of hours > 24 because the goal could be 
    // for 30, 35, 40...hours. However when the segmented control is set to 'Day' then there should be no more than 24 hours to select
    @IBAction func weekDaySelect(sender: AnyObject) {
        // First we need to reset the variables storing the time picked to 0 (since the UIPicker is reset to 0)
        self.hoursChosen = 0
        self.minutesChosen = 0
        
        var segmentedControl = sender as UISegmentedControl
        var selectionInteger = segmentedControl.selectedSegmentIndex
        var componentSelectedinHours = hoursAndMinutesPicker.selectedRowInComponent(0)
        
        // if the selection is 0 ('Week') then the weekGoalHours array (with > 24 hours) is used to populate the hours component of the UIPicker
        if selectionInteger == 0 {
            println("*****\nWeek is selected")
            self.goalSetPerWeek = true
            self.picker.selectRow(0, inComponent: 0, animated: true)
            self.picker.selectRow(self.goalTimeData[2].count / 2, inComponent: 2, animated: true)
            
            self.goalTimeData[0] = self.weekGoalHours
            // the reloadAllComponents is to make sure that the latest components have been reloaded correctly in the UIPicker, and that it has been reset properly
            self.hoursAndMinutesPicker.reloadAllComponents()
            println("finished reloadingAllComponents with the weekGoalHours")
            
        }
            
        // if the selection is not set to 0 then it has to be set to 1 ('Day') and the the dayGoalHours array (with 0 to 24 hours) is used to populate the hours component of the UIPicker
        else {
            println("*****\nDay is selected")
            goalSetPerWeek = false
            // This first condition is checked to ensure that the hours reset animation works properly (since the number of values in dayGoalHours is < weekGoalHours, there were issues with the hour reset animation when the selected number on the picker was above 24)
            if componentSelectedinHours >= 25 {
                println("reducing fast")
                self.picker.selectRow(24, inComponent: 0, animated: false)
            }
 
                // Go back to 0 by using an animation for both
                self.picker.selectRow(0, inComponent: 0, animated: true)
                self.picker.selectRow(self.goalTimeData[2].count / 2, inComponent: 2, animated: true)
            
            self.goalTimeData[0] = self.dayGoalHours
            self.hoursAndMinutesPicker.reloadAllComponents()
            println("finished reloadingAllComponents with the dayGoalHours")
        }
    }
    

    @IBAction func allWeekTap(sender: UITapGestureRecognizer) {
        tickAllCheckboxes()
    }
    @IBAction func mondayTap(sender: UITapGestureRecognizer) {
        tickCheckbox("Monday")
    }
    @IBAction func tuesdayTap(sender: UITapGestureRecognizer) {
        tickCheckbox("Tuesday")
    }
    @IBAction func wednesdayTap(sender: UITapGestureRecognizer) {
        tickCheckbox("Wednesday")
    }
    @IBAction func thursdayTap(sender: UITapGestureRecognizer) {
        tickCheckbox("Thursday")
    }
    @IBAction func fridayTap(sender: UITapGestureRecognizer) {
        tickCheckbox("Friday")
    }
    @IBAction func saturdayTap(sender: UITapGestureRecognizer) {
        tickCheckbox("Saturday")
    }
    @IBAction func sundayTap(sender: UITapGestureRecognizer) {
        tickCheckbox("Sunday")
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {

    }
    
    @IBOutlet weak var goalName: UITextField!

    @IBOutlet weak var picker: UIPickerView!
    
    // I want the minutes component in the UIPicker to look like it is an infinite loop
    // As a solution I create a really long array 'lotsOfMintues' which is going to be
    // multiples of the 'WeekGoalMinutes' array
    var weekGoalMinutes = ["00","05","10","15","20","25","30","35","40","45","50","55"]
    var lotsOfWeekGoalMinutes = [String] ()
    var dayGoalMinutes = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    var lotsOfDayGoalMinutes: [String] = []
    
    var weekGoalHours = [" 0"," 1"," 2"," 3"," 4"," 5"," 6"," 7"," 8"," 9", "10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48"]
    
    var dayGoalHours = [" 0"," 1"," 2"," 3"," 4"," 5"," 6"," 7"," 8"," 9", "10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    
    var goalTimeData = [[""],["hours"],[""],["min"]]
    
    // create a dictionary that will store a UIView-Bool key-value pair to indciate whether a day checkboxes is ticked on or off
    var checkBoxState = [String: Bool]()
    var checkBoxView = [String: UIView]()
    
    // variable that indicates the nubmer of checkboxes that are checked (which is 0 when ViewDidLoad begins)
    var boxesChecked = 0
    
    // The checkboxes for each day switch to blue when they are checked and to white when they are unchecked
    // The whiteTransition and blueTransition store the UIColor and are called by some functions
    var whiteTransition = UIColor.whiteColor()
    var blueTransition = UIColor(red:0.0, green:128.0 / 255.0, blue:255.0 / 255.0, alpha:1.0)


    
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
    
    
    // Catpure the selection made using the UIPicker showing the time options
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // The timeJustPicked variable stores a string which is the one just selected using the time picker
        // it will then be transformed into an Int, then stored into the hoursChosen or minutesChosen variable (depending on which section was selected in the picker)
        var timeJustPicked = self.goalTimeData[component][row]
        
        if self.goalTimeData[component] == self.goalTimeData[0] {
            self.hoursChosen = timeJustPicked.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).toInt()!
            println("hours chosen in picker: \(self.hoursChosen)")}
        
        else if self.goalTimeData[component] == self.goalTimeData[2]{
            self.minutesChosen = timeJustPicked.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).toInt()!
            println("minute chosen in picker: \(self.minutesChosen)")

        }
    }
    
    // Ensure all the checkboxes are either checked or unchecked
    func tickAllCheckboxes() {
        if self.checkBoxState["All Week"] == false {

            for (name, state) in self.checkBoxState {
                if self.checkBoxState[name] == false {
                    self.checkBoxState[name] = true
                    animateCheckbox(self.checkBoxView[name]!, color: self.blueTransition)
                }
            }
            self.boxesChecked = 8
        } else {
            for (name, state) in self.checkBoxState {
                self.checkBoxState[name] = false
                animateCheckbox(self.checkBoxView[name]!, color: self.whiteTransition)
            }
            self.boxesChecked = 0
        }
        println("number of boxesChecked \(self.boxesChecked)")
        var naming = "All Week"
        println("status of All Week: \(self.checkBoxState[naming])")
        
    }
    
    // the animateCheckbox color helps transition a checkbox from one color to another
    func animateCheckbox(checkbox: UIView, color: UIColor){
        UIView.animateWithDuration(0.2, animations: {checkbox.backgroundColor = color})
        println("ANIMATE")
        
    }
    
    // the tickCheckbox function is for the day-of-the-week 'buttons'
    // to check/uncheck them. If it is called and all the days of the
    // week are checked, then the "All Week" checkbox also needs to be checked on.
    // If all days of the week (and the "All Week" checkbox) were checked on
    // and it is called, then the checkboxes for both the day clicked and "All Week" are checked off
    func tickCheckbox(dayCheckBox: String) {
        var checkboxIcon = self.checkBoxView[dayCheckBox]
        
        if self.checkBoxState[dayCheckBox] == true {
            self.checkBoxState[dayCheckBox] = false
            println("First loop: status for \(dayCheckBox) changed to: \(self.checkBoxState[dayCheckBox])")
            var transitionColor = UIColor.whiteColor()
            animateCheckbox(checkboxIcon!, color: transitionColor)
            
            self.boxesChecked -= 1
            println("First loop: boxesChecked is now at \(self.boxesChecked)")
            
            // checks whether unchecking the day checkbox now means that "All Week" should also be unchecked
            if self.boxesChecked == 7 {
                self.checkBoxState["All Week"] = false
                animateCheckbox(self.checkBoxView["All Week"]!, color: whiteTransition)
                var naming = "All Week"
                println("first loop sub: the status for All Week is now: \(self.checkBoxState[naming])")
                self.boxesChecked -= 1
                println("first loop sub: boxesChecked is now at \(self.boxesChecked)")
            }
            
        }
        else {
            self.checkBoxState[dayCheckBox] = true
            println("the checkbox value for the day is: \(self.checkBoxState[dayCheckBox])")
            animateCheckbox(checkboxIcon!, color: blueTransition)
            self.boxesChecked += 1
            println("else loop: boxesChecked is now at \(self.boxesChecked)")
            
            // checks whether checking the day checkbox now means that "All Week" should also be checked
            if self.boxesChecked == 7 {
                self.checkBoxState["All Week"] = true
                animateCheckbox(self.checkBoxView["All Week"]!, color: blueTransition)
                self.boxesChecked += 1
                println("End else loop: boxesChecked is now at \(self.boxesChecked)")
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goalName.delegate = self
        
        self.picker.dataSource = self
        self.picker.delegate = self
        
        // At first, all the checkboxes inside the day boxes will be ticked on (i.e. their value in the checkBoxState dictionary should be 'false')
        self.checkBoxState = ["All Week": false,"Monday":false,"Tuesday":false,"Wednesday":false,"Thursday":false,"Friday":false,"Saturday":false,"Sunday":false]
        self.checkBoxView = ["All Week": self.allWeekCheckbox,"Monday":self.mondayCheckbox,"Tuesday":self.tuesdayCheckbox,"Wednesday":self.wednesdayCheckbox,"Thursday":self.thursdayCheckbox,"Friday":self.fridayCheckbox,"Saturday":self.saturdayCheckbox,"Sunday":self.sundayCheckbox]
        
        // Then call the tickAllCheckboxes function to change the color of all checkboxes to blue (i.e. 'ticked')
        self.tickAllCheckboxes()
        
        
        // Here I add multiple copies of 'weekGoalMinutes' into the 'lotsOfWeekGoalMinutes' array. I do the same for 'dayGoalMinutes' and 'lotsOfdayGoalMinutes'
        for i in 0...99 {
            self.lotsOfWeekGoalMinutes += self.weekGoalMinutes
            self.lotsOfDayGoalMinutes += self.dayGoalMinutes
        }
        
        // I then set up the 'weekGoalHours' (0 to 48) as the array for the hours and the 'lotsOfDayGoalMinutes' (many times 0 to 59) as the array for the minutes
        // the 'goaltTimeData' array of arrays
//        self.goalTimeData.insert(self.lotsOfDayGoalMinutes, atIndex: self.goalTimeData.count-1)
        self.goalTimeData[0] = self.weekGoalHours
        self.goalTimeData[2] = self.lotsOfDayGoalMinutes
        
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
