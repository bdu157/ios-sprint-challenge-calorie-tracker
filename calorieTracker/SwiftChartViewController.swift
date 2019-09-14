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
            self.makeDatas()
        }
    }
    
    let chart = Chart(frame: CGRect(x: 0, y: 0, width: 380, height: 200))
    
    let array: [Double] = [300, 400, 600, 100, 600, 100, 200]
    
    let series = ChartSeries([300, 400, 600, 100, 600, 100, 200, 100, 200, 500])
    
    //var series: ChartSeries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chart)
        chart.backgroundColor = .cyan
        chart.add(series)
        //observeShouldShowNewIntake()
    }
    
    
    func observeShouldShowNewIntake() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews(notification:)), name: .caloriesInput, object: nil)
    }
    
    @objc func refreshViews(notification: Notification) {
//        self.chart.add(self.series)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    private func makeDatas() {

        guard let intake = intake else {return}

    }
    
    
    private func updateViews() {
        //update chart
        guard let intake = intake else {return}
        
    }
    
}
