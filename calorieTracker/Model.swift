//
//  Model.swift
//  calorieTracker
//
//  Created by Dongwoo Pae on 9/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

struct Tracker {
    let calories: Int
    let date: Date
    
    init(calories: Int, date: Date = Date()) {
        self.calories = calories
        self.date = date
    }
}
