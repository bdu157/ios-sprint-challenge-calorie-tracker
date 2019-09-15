//
//  Calories+Convenience.swift
//  calorieTracker
//
//  Created by Dongwoo Pae on 9/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData

extension Calories {
    convenience init(calories: Double, date: Date = Date(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.calories = calories
        self.date = date
    }
}
