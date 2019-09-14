//
//  MainTableViewController.swift
//  calorieTracker
//
//  Created by Dongwoo Pae on 9/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import SwiftChart

class MainTableViewController: UITableViewController {
    
    let modelController = ModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeShouldShowNewIntake()
    }
    
    func observeShouldShowNewIntake() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews(notification:)), name: .caloriesInput, object: nil)
    }
    
    @objc func refreshViews(notification: Notification) {
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.modelController.intakes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let intake = self.modelController.intakes[indexPath.row]
        cell.textLabel?.text = "Calories: \(intake.calories)" + "   \(intake.date)"
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func addCalrorieButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Calories Intake", message: "Enter the amount of calories in the field", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Calories"
        }
        
        let submitAction = UIAlertAction(title: "SUBMIT", style: .default) { (_) in
            let input = Int(alert.textFields![0].text!)
            if let input = input {
                self.modelController.createNewIntake(for: input)
                
                NotificationCenter.default.post(name: .caloriesInput, object: self)
            }
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)

    }
}

extension Notification.Name {
    static var caloriesInput = Notification.Name("caloriesInput")
}
