//
//  ModelController.swift
//  calorieTracker
//
//  Created by Dongwoo Pae on 9/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData

class ModelController {
    
    //var intakes: [Tracker] = []
    
    func createNewIntake(for input: Double) -> Calories {
        let object = Calories(calories: input)
        //intakes.append(intake)
        saveToPersistentStore()
        return object
    }
    

    // savetopersistentstore
    func saveToPersistentStore() {
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error saving managed object context:\(error)")
        }
    }
}
