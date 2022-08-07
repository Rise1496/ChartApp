//
//  EnterCountViewController.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Core

final class EnterCountViewController: BaseViewController, EnterCountViewInput, EnterCountViewOutput {
    var viewModel: EnterCountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
