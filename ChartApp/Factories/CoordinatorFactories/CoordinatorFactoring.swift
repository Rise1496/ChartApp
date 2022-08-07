//
//  CoordinatorFactoring.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Moya
import Core

protocol CoordinatorFactoring {
    func makeMainCoordinator(factory: MainModuleFactoring,
                             router: Routerable,
                             provider: MoyaProvider<APIProvider>) -> MainCoordinator
}
