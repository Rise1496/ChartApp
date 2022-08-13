//
//  EnterCountViewOutput.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Core

protocol EnterCountViewOutput: BaseView {
    var onChartOpen: (() -> Void)? { get set }
}
