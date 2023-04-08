//
//  LineGraph.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 08/04/23.
//

import Foundation
import SwiftUI
import Charts
import UIKit
class LineGraphView: UIView {
    
    var data: [CGFloat] = []
    var lineColor: UIColor = .blue
    let lineWidth: CGFloat = 2
    let yAxisLabelCount: Int = 8
    let numColumns = 8
    var dates: [String] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Set up the background color and grid lines
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: 0, y: rect.height))
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.setLineWidth(0.5)
        
        // Draw the vertical grid lines
        
        let columnSpacing = rect.width / CGFloat(numColumns - 1)
        for i in 0..<numColumns {
            let x = columnSpacing * CGFloat(i)
            context?.move(to: CGPoint(x: x, y: 0))
            context?.addLine(to: CGPoint(x: x, y: rect.height))
            context?.strokePath()
            
            // Draw X-axis labels for months
            if i < numColumns {
                let monthLabel = UILabel(frame: CGRect(x: x - (columnSpacing/2), y: rect.height, width: columnSpacing, height: 20))
                monthLabel.textAlignment = .center
                monthLabel.font = UIFont.systemFont(ofSize: 10)
                monthLabel.textColor = UIColor.lightGray
                monthLabel.text = (dates[safe: (dates.count/numColumns + 1)*i]?.convertToCustomDateFormat()) ?? dates.last?.convertToCustomDateFormat()
                self.addSubview(monthLabel)
            }
        }
        
        // Draw the horizontal grid lines and Y-axis labels for numbers
        let numRows = yAxisLabelCount
        let rowSpacing = rect.height / CGFloat(numRows - 1)
        for i in 0..<numRows {
            let y = rowSpacing * CGFloat(i)
            context?.move(to: CGPoint(x: 0, y: y))
            context?.addLine(to: CGPoint(x: rect.width, y: y))
            context?.strokePath()
            
            // Draw Y-axis labels for numbers
            let label = UILabel(frame: CGRect(x: 0 - columnSpacing - 16, y: y - 10, width: 30, height: 20))
            label.textAlignment = .right
            label.font = UIFont.systemFont(ofSize: 10)
            label.textColor = UIColor.lightGray
            label.text = "\(Int((1 - CGFloat(i) / CGFloat(numRows - 1)) * data.max()!))"
            self.addSubview(label)
        }
        
        // Draw the line chart
        context?.setStrokeColor(lineColor.cgColor)
        context?.setLineWidth(lineWidth)
        let shadowColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3)
        context?.setShadow(offset: CGSize(width: 0, height: 30), blur: 32, color: UIColor.blue.cgColor) // Add shadow to the line
        let maxValue = data.max() ?? 1
        let xSpacing = rect.width / CGFloat(data.count - 1)
        context?.move(to: CGPoint(x: 0, y: rect.height))
        for i in 0..<data.count {
            let x = xSpacing * CGFloat(i)
            let y = rect.height - (data[i] / maxValue) * rect.height
            context?.addLine(to: CGPoint(x: x, y: y-2))
        }
        context?.strokePath()

    }
    
}

