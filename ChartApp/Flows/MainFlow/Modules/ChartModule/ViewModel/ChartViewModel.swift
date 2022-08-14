//
//  ChartViewModel.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 13.08.2022.
//

import Charts

final class ChartViewModel {
    
    enum Cell {
        case chartCell(viewModel: ChartTableViewCell.ViewModel)
        case pointCell(viewModel: PointTableViewCell.ViewModel)
    }
    
    // MARK: - Internal properties
    
    var cells = [Cell]()
    let pointsResponse: PointsResponse
    
    // MARK: - Lifecycle
    
    init(pointsResponse: PointsResponse) {
        self.pointsResponse = pointsResponse
        
        let chartEntries = pointsResponse.points.map({ return ChartDataEntry(x: $0.x, y: $0.y) })
        let sortedCahrtEntries = chartEntries.sorted(by: { return $0.x < $1.x })
        _ = sortedCahrtEntries.map({ [weak self] entry in
            self?.cells.append(.pointCell(viewModel: PointTableViewCell.ViewModel(dataEntry: entry)))
            return
        })
        cells.append(.chartCell(viewModel: ChartTableViewCell.ViewModel(dataEntries: sortedCahrtEntries)))
    }
}
