//
//  SwiftChartViewController.swift
//  calorieTracker
//
//  Created by Dongwoo Pae on 9/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import SwiftChart

class SwiftChartViewController: UIViewController {

    var intake: Int? {
        didSet {
            self.updateViews()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chart = Chart(frame: CGRect(x: 0, y: 0, width: 450, height: 200))
        view.addSubview(chart)
        chart.backgroundColor = .cyan
    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    private func updateViews() {
        //update chart
        guard let intake = intake else {return}
        
        
    }

}
