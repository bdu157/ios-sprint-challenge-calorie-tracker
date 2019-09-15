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
    
    var data: [Double] = [] {
        didSet {
            observeShouldUpdateChart()
        }
    }
    
    let chart = Chart(frame: CGRect(x: 0, y: 0, width: 380, height: 200))
    
    //var series: ChartSeries
    //let data: [Double] = [0, 3, 5, 3, 3, 1, 1, 0, 5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chart)
        chart.backgroundColor = .cyan
        observeShouldUpdateChart()
    }
    
    
    func observeShouldUpdateChart() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateChart(notification:)), name: .caloriesInput, object: nil)
    }
    
    @objc func updateChart(notification: Notification) {
        DispatchQueue.main.async {
            self.makeDatas()
        }
    }
    
    private func makeDatas() {
        let series = ChartSeries(self.data)
        self.chart.add(series)
    }
    
}
