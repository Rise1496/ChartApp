//
//  EnterCountViewModel.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import RxMoya
import Moya
import RxCocoa
import RxSwift

class EnterCountViewModel {
    private let provider: MoyaProvider<APIProvider>
    private let disposeBag = DisposeBag()
    
    let countRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init(provider: MoyaProvider<APIProvider>) {
        self.provider = provider
    }
    
    func makePointsRequest(completionBlock: (()-> Void)?, failureBlock: ((String) -> Void)?) {
        guard let count = Int(countRelay.value) else {
            return
        }
        let getPointsRequest = getPointsRequestObservable(count: count)
        getPointsRequest.subscribe(onNext: { [weak self] (result) in
            switch result {
            case .success(let response):
                completionBlock?()
            case .failed(let message):
                failureBlock?(message)
            }
        }, onError: { error in
            failureBlock?(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}

extension EnterCountViewModel {
    private func getPointsRequestObservable(count: Int) -> Observable<PointsRequestResult> {
        return provider.rx.request(.getChart(count: count)).map(PointsResponse.self).map { model in
            return PointsRequestResult.success(response: model)
        }.catchAndReturn(PointsRequestResult.failed(message:
                "Error")).asObservable()
    }
}
