//
//  PointTableViewCell.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 13.08.2022.
//

import UIKit
import Charts

final class PointTableViewCell: UITableViewCell {
    class ViewModel {
        let dataEntry: ChartDataEntry
        
        init(dataEntry: ChartDataEntry) {
            self.dataEntry = dataEntry
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var xLabel: UILabel = {
        return UILabel()
    }()
    
    private lazy var yLabel: UILabel = {
        return UILabel()
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
        addSubview(stackView)
        stackView.addArrangedSubview(xLabel)
        stackView.addArrangedSubview(yLabel)
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        })
    }
    
    func setup(viewModel: ViewModel) {
        xLabel.text = "x: \(viewModel.dataEntry.x)"
        yLabel.text = "y: \(viewModel.dataEntry.y)"
    }
}
