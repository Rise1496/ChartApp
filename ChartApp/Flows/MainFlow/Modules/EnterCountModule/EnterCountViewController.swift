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
        button.setTitle("Let's go", for: .normal)
        return button
    }()
    
    lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Information"
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        view.addSubview(textField)
        view.addSubview(applyButton)
        view.addSubview(informationLabel)
        view.addSubview(activityIndicator)
        
        textField.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        })
        
        informationLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(textField.snp.top).offset(-20)
            make.leading.equalTo(textField.snp.leading)
            make.trailing.equalTo(textField.snp.trailing)
        })
        
        applyButton.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
            make.top.equalTo(textField.snp.bottom).offset(10)
        })
        
        activityIndicator.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
        })
    }
    
    override func setupBindings() {
        textField.rx.text.orEmpty.bind(to: viewModel.countRelay).disposed(by: disposeBag)
    }
    
    @objc private func applyButtonTapped() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        viewModel.makePointsRequest(completionBlock: { [weak self] in
            self?.view.isUserInteractionEnabled = true
            self?.activityIndicator.stopAnimating()
            self?.onChartOpen?()
        }, failureBlock: { [weak self] error in
            self?.view.isUserInteractionEnabled = true
            self?.activityIndicator.stopAnimating()
            self?.showErrorAlertWith(error)
        })
    }
}
