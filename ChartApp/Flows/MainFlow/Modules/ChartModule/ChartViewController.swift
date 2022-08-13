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
        tableView.dataSource = self
        tableView.refreshControl = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save image", style: .plain,
                                                            target: self, action: #selector(saveTapped))
    }
    
    override func registerCells() {
        super.registerCells()
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.className)
        tableView.register(PointTableViewCell.self, forCellReuseIdentifier: PointTableViewCell.className)
    }
    
    @objc private func saveTapped() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: viewModel.cells.count - 1,
                                                            section: 0)) as? ChartTableViewCell else {
            return
        }
        guard let image = cell.getImage() else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
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
            
        case .pointCell(let viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            PointTableViewCell.className) as? PointTableViewCell else {
                return UITableViewCell()
            }
            cell.setup(viewModel: viewModel)
            cell.selectionStyle = .none
            return cell
        }
    }
}
