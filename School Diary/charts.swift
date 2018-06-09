
//
//  charts.swift
//  School Diary
//
//  Created by Carmine Cuofano on 30/09/17.
//  Copyright © 2017 Carmine Cuofano. All rights reserved.
//

import UIKit
import Charts

class charts: LineChartView {

    func setChart(info: [Double]) {

        var circleColors : [UIColor] = []
        var lineColors : [UIColor] = []

        var dataEntries: [ChartDataEntry] = []

        for (i,value) in info.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(i + 1), y: value)
            dataEntries.append(dataEntry)
            switch value {
            case 0..<5: circleColors.append(.red)
            case 5..<6: circleColors.append(.yellow)
            default: circleColors.append(.green)
            }
            lineColors.append(.red)
        }

        dataEntries.insert(ChartDataEntry(x: 0, y: 0), at: 0)
        circleColors.insert(.clear, at: 0)
        lineColors.insert(.clear,at: 0)
        dataEntries.append(ChartDataEntry(x: Double(info.count + 1), y: 10.0))
        circleColors.append(.clear)
        lineColors[lineColors.indices.last!] = .clear
        let pieChartDataSet = LineChartDataSet(values: dataEntries, label: " ")
        let pieChartData = LineChartData(dataSet: pieChartDataSet)
        pieChartDataSet.circleColors = circleColors
        pieChartDataSet.colors = lineColors
        self.data = pieChartData
    }

}
