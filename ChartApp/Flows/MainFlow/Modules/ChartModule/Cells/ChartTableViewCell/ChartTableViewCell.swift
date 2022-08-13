//
//  ChartTableViewCell.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 13.08.2022.
//

import Charts
import SnapKit
import UIKit

final class ChartTableViewCell: UITableViewCell {
    class ViewModel {
        let dataEntries: [ChartDataEntry]
        
        init(dataEntries: [ChartDataEntry]) {
            self.dataEntries = dataEntries
        }
    }
    
    private lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.delegate = self
        chartView.chartDescription.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0
        return chartView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(chartView)
    }
    
    private func makeConstraints() {
        chartView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
            make.height.equalTo(500)
        })
    }
    
    func setup(viewModel: ViewModel) {
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        let axisMaximum = viewModel.dataEntries.max(by: { return $1.y > $0.y })?.y
        let axisMinimum = viewModel.dataEntries.min(by: { return $1.y > $0.y })?.y
        leftAxis.axisMaximum = axisMaximum ?? 0.0
        leftAxis.axisMinimum = axisMinimum ?? 0.0
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        let xAxisMinimum = viewModel.dataEntries.min(by: { return $1.x > $0.x })?.x
        chartView.xAxis.axisMinimum = xAxisMinimum ?? 0.0
        
        let set1 = LineChartDataSet(entries: viewModel.dataEntries, label: "DataSet 1")
        set1.drawIconsEnabled = false
        setup(set1)
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set1.fillAlpha = 1
        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)

        chartView.data = data
    }
    
    private func setup(_ dataSet: LineChartDataSet) {
        if dataSet.isDrawLineWithGradientEnabled {
            dataSet.lineDashLengths = nil
            dataSet.highlightLineDashLengths = nil
            dataSet.setColors(.black, .red, .white)
            dataSet.setCircleColor(.black)
            dataSet.gradientPositions = [0, 40, 100]
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = nil
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        } else {
            dataSet.lineDashLengths = [5, 2.5]
            dataSet.highlightLineDashLengths = [5, 2.5]
            dataSet.setColor(.black)
            dataSet.setCircleColor(.black)
            dataSet.gradientPositions = nil
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = [5, 2.5]
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        }
    }
}

extension ChartTableViewCell: ChartViewDelegate {
    
}

extension NSObject {

    public class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    public var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }

    public static var nibName: String {
        return String(describing: self)
    }

    public static var className: String {
        return String(describing: self)
    }

}
