//
//  CoordinatorFactory.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Moya
import Core

final class CoordinatorFactory: CoordinatorFactoring {
    func makeMainCoordinator(factory: MainModuleFactoring,
                             router: Routerable,
                             provider: MoyaProvider<APIProvider>) -> MainCoordinator {
        return MainCoordinator(factory: factory, router: router,
                               provider: provider)
    }
}
