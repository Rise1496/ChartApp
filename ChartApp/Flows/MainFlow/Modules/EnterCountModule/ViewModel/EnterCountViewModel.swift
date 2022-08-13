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

final class EnterCountViewModel {
    private let provider: MoyaProvider<APIProvider>
    private let disposeBag = DisposeBag()
    
    let countRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    var pointsResponse: PointsResponse?
    
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
                self?.pointsResponse = response
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
        return provider.rx.request(.getChart(count: count)).filterSuccessfulStatusCodes().map(PointsResponse.self).map { model in
            return PointsRequestResult.success(response: model)
        }.asObservable().catch({ error in
            if let moyaError = error as? MoyaError {
                var errorString = moyaError.localizedDescription
                switch moyaError.response?.statusCode {
                case 400:
                    errorString = "Requested number of point is invalid"
                case 500:
                    errorString = "Server error"
                default:
                    break
                }
                return .just(PointsRequestResult.failed(message: errorString))
            } else {
                return .just(PointsRequestResult.failed(message: error.localizedDescription))
            }
        }).asObservable()
    }
}
