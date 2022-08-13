//
//  EnterCountViewOutput.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Core

typealias Action = (() -> Void)
typealias StringAction = ((String) -> Void)

protocol EnterCountViewOutput: BaseView {
    var onChartOpen: Action? { get set }
}
