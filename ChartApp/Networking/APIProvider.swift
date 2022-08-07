//
//  APIProvider.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

import Foundation
import Moya

struct APIConfig {
    static let chartURL = "https://hr-challenge.interactivestandard.com"
}

struct ParameterName {
    static let count = "count"
}

enum APIProvider {
    case getChart(count: Int)
}

extension APIProvider: TargetType {
    var baseURL: URL {
        switch self {
        case .getChart:
            return URL(string: APIConfig.chartURL)!
        }
    }
    
    var path: String {
        switch self {
        case .getChart:
            return "/sequeniatesttask/films.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getChart:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getChart:
            return Data()
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .getChart:
            return URLEncoding.default
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getChart(let count):
            return [ParameterName.count: count]
        }
    }
    
    var task: Task {
        switch self {
        case .getChart:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getChart:
            return [:]
        }
    }
}
