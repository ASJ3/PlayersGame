//
//  Goal.swift
//  GoalProject
//
//  Created by Alexis Saint-Jean on 2/10/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import Foundation
class Goal: NSObject {
    var goalName = ""
    var goalDays = [String: Bool]()
    var goalMinutes = 0
    var timeLogged  = 0.0
    var goalSetPerWeek = true
    init(goalName: String, goalDays: [String: Bool], goalMinutes: Int, goalSetPerWeek: Bool){
        self.goalName = goalName
        self.goalDays = goalDays
        self.goalMinutes = goalMinutes
        self.goalSetPerWeek = goalSetPerWeek
    }
    
//    func description()->String {
//        return "Name of the goal: \(self.goalName)\nMinutes per week:\(self.goalMinutes)\nTime logged so far: \(self.timeLogged)\nGoal is set on a weekly basis: \(self.goalSetPerWeek)"
//    }
}
