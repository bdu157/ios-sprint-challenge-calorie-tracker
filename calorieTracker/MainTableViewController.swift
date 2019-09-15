//
//  MainTableViewController.swift
//  calorieTracker
//
//  Created by Dongwoo Pae on 9/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import SwiftChart
import CoreData

class MainTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    lazy var fetchedResultsController: NSFetchedResultsController<Calories> = {
        let fetchRequest: NSFetchRequest<Calories> = Calories.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()
    
    
    let modelController = ModelController()
    var swiftChartViewController: SwiftChartViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeShouldShowNewIntake()
        if let object = fetchedResultsController.fetchedObjects {
            NotificationCenter.default.post(name: .caloriesInput, object: self)
            swiftChartViewController.data = object.map {$0.calories}
        }
        
        //if fetchedResultsController.oject exists then assign array of calories [Double] to var data: [Double] = []  in SwiftChartViewController
    }
    
    func observeShouldShowNewIntake() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews(notification:)), name: .caloriesInput, object: nil)
    }
    
    @objc func refreshViews(notification: Notification) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let intake = self.fetchedResultsController.object(at: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let date = dateFormatter.string(from: intake.date!)

        let intValue = Int(intake.calories)
        cell.textLabel?.text = "Calories:\(intValue)" + " \(date)"
        return cell
    }
 
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SwiftChartEmbedSegue" {
            self.swiftChartViewController = segue.destination as! SwiftChartViewController
        }
    }
    
    @IBAction func addCalrorieButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Calories Intake", message: "Enter the amount of calories in the field", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Calories"
        }
        
        let submitAction = UIAlertAction(title: "SUBMIT", style: .default) { (_) in
            let input = Double(alert.textFields![0].text!)
            if let input = input {
                let object = self.modelController.createNewIntake(for: input)
                
                NotificationCenter.default.post(name: .caloriesInput, object: self)
            
                self.updateData(for: object)
            }
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func updateData(for object: Calories) {
        swiftChartViewController.data.append(object.calories)
//        if let object = fetchedResultsController.fetchedObjects {
//            swiftChartViewController.data = object.map{$0.calories}
//        }
    }
    
    //MARK: - NSfetchresultcontrollerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    
    //Sections
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    //Rows
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
}

extension Notification.Name {
    static var caloriesInput = Notification.Name("caloriesInput")
}
