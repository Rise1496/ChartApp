//
//  MainCoordinator.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Core
import Moya

class MainCoordinator: BaseCoordinator {
    private let factory: MainModuleFactoring
    private let router: Routerable
    private let provider: MoyaProvider<APIProvider>
    
    init(factory: MainModuleFactoring, router: Routerable,
         provider: MoyaProvider<APIProvider>) {
        self.factory = factory
        self.router = router
        self.provider = provider
        super.init()
    }
    
    override func start() {
        showEnterCountModule()
    }
    
    private func showEnterCountModule() {
        var enterCountModule = factory.makeEnterCountModule()
        enterCountModule.viewModel = EnterCountViewModel(provider: provider)
        enterCountModule.onChartOpen = { [weak self, weak enterCountModule] in
            guard let pointsReponse = enterCountModule?.viewModel.pointsResponse else {
                return
            }
            self?.showChartModule(pointsResponse: pointsReponse)
        }
        router.setRootModule(enterCountModule)
    }
    
    private func showChartModule(pointsResponse: PointsResponse) {
        let chartModule = ChartViewController()
        chartModule.viewModel = ChartViewModel(pointsResponse: pointsResponse)
        router.push(chartModule)
    }
}
