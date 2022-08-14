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
    
    // MARK: - Private properties
    
    private let provider: MoyaProvider<APIProvider>
    private let disposeBag = DisposeBag()
    
    // MARK: - Internal properties
    
    let countRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    var pointsResponse: PointsResponse?
    
    // MARK: - Lifecycle
    
    init(provider: MoyaProvider<APIProvider>) {
        self.provider = provider
    }
    
    // MARK: - Internal methodes
    
    func makePointsRequest(completionBlock: Action?, failureBlock: StringAction?) {
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

// MARK: - Observable request

extension EnterCountViewModel {
    private func getPointsRequestObservable(count: Int) -> Observable<PointsRequestResult> {
        return provider.rx.request(.getChart(count: count)).filterSuccessfulStatusCodes().map(PointsResponse.self).map { model in
            return PointsRequestResult.success(response: model)
        }.asObservable().catch({ error in
            if let moyaError = error as? MoyaError {
                var errorString = moyaError.localizedDescription
                switch moyaError.response?.statusCode {
                case 400:
                    errorString = "EnterCount.Error.400".localized
                case 500:
                    errorString = "EnterCount.Error.500".localized
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
