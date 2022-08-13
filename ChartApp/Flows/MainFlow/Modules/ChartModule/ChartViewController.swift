//
//  ChartViewController.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 13.08.2022.
//

import Core
import Foundation
import UIKit

final class ChartViewController: BaseTableViewController, ChartViewInput, ChartViewOutput {
    var viewModel: ChartViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        tableView.dataSource = self
        tableView.refreshControl = nil
    }
    
    override func registerCells() {
        super.registerCells()
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.className)
    }
}

extension ChartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cells[indexPath.row] {
        case .chartCell(let viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            ChartTableViewCell.className) as? ChartTableViewCell else {
                return UITableViewCell()
            }
            cell.setup(viewModel: viewModel)
            cell.selectionStyle = .none
            return cell
        }
    }
}
