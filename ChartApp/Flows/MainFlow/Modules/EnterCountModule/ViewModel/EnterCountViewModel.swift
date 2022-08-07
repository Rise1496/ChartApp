//
//  EnterCountViewModel.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Moya

class EnterCountViewModel {
    private let provider: MoyaProvider<APIProvider>
    
    init(provider: MoyaProvider<APIProvider>) {
        self.provider = provider
    }
}
