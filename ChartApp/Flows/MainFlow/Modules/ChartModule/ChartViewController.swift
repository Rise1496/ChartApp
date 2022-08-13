//
//  ChartViewController.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 13.08.2022.
//

import Core

final class ChartViewController: BaseTableViewController, ChartViewInput, ChartViewOutput {
    var viewModel: ChartViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}
