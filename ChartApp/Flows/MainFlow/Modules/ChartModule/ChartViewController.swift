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
    
    private var chartCell: ChartTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = nil
    }
    
    override func registerCells() {
        super.registerCells()
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.className)
        tableView.register(PointTableViewCell.self, forCellReuseIdentifier: PointTableViewCell.className)
    }
    
    @objc private func saveTapped() {
        guard let cell = chartCell else {
            return
        }
        guard let image = cell.getImage() else {
            showErrorAlertWith("Unable to capture chart")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showErrorAlertWith(error.localizedDescription)
        } else {
            let alert = UIAlertController(title: "", message: "Completed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Alert.Button.OK".localized, style: .default) { _ in })
            present(alert, animated: true, completion: nil)
        }
    }
}

extension ChartViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ChartTableViewCell {
            self.chartCell = cell
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save image", style: .plain,
                                                                target: self, action: #selector(saveTapped))
        }
    }
}
