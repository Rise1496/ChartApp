//
//  EnterCountViewModel.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Moya
import RxCocoa

class EnterCountViewModel {
    private let provider: MoyaProvider<APIProvider>
    
    let countRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init(provider: MoyaProvider<APIProvider>) {
        self.provider = provider
    }
}
