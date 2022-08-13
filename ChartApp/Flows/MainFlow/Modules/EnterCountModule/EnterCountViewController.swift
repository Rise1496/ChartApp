//
//  EnterCountViewController.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Core
import UIKit
import SnapKit

final class EnterCountViewController: BaseViewController, EnterCountViewInput, EnterCountViewOutput {
    var viewModel: EnterCountViewModel!
    
    var onChartOpen: Action?
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = "Enter count"
        textField.layer.cornerRadius = 5.0
        textField.backgroundColor = .gray
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        button.setTitle("Apply", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        view.addSubview(textField)
        view.addSubview(applyButton)
        
        textField.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        })
        
        applyButton.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
            make.top.equalTo(textField.snp.bottom).offset(10)
        })
    }
    
    override func setupBindings() {
        textField.rx.text.orEmpty.bind(to: viewModel.countRelay).disposed(by: disposeBag)
    }
    
    @objc private func applyButtonTapped() {
        viewModel.makePointsRequest(completionBlock: { [weak self] in
            self?.onChartOpen?()
        }, failureBlock: { [weak self] error in
            self?.showErrorAlertWith(error)
        })
    }
}
