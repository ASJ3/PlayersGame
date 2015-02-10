//
//  SecondViewController.swift
//  GoalProject
//
//  Created by Alexis Saint-Jean on 2/10/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var weekDaySelect: UISegmentedControl!
    @IBOutlet weak var goalName: UITextField!
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

    @IBOutlet weak var hoursAndMinutesPicker: UIPickerView!
    @IBOutlet weak var picker: UIPickerView!
    @IBAction func saveButton(sender: AnyObject) {
    }
    @IBAction func cancelButton(sender: AnyObject) {
    }

    @IBAction func sundayTap(sender: UITapGestureRecognizer) {
    }
    @IBAction func saturdayTap(sender: UITapGestureRecognizer) {
    }
    @IBAction func fridayTap(sender: UITapGestureRecognizer) {
    }
    @IBAction func thursdayTap(sender: UITapGestureRecognizer) {
    }
    @IBAction func wednesdayTap(sender: UITapGestureRecognizer) {
    }
    @IBAction func tuesdayTap(sender: UITapGestureRecognizer) {
    }
    @IBAction func mondayTap(sender: UITapGestureRecognizer) {
    }
    @IBAction func allWeekTap(sender: UITapGestureRecognizer) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
