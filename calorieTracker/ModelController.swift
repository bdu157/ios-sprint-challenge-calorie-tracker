//
//  ModelController.swift
//  calorieTracker
//
//  Created by Dongwoo Pae on 9/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

class ModelController {
    
    var intakes: [Tracker] = []
    
    func createNewIntake(for calrories: Int) {
        let intake = Tracker(calories: calrories)
        intakes.append(intake)
    }
}
