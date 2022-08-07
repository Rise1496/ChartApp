//
//  PointsRequestResult.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 07.08.2022.
//

struct Point: Codable {
    let x: Double
    let y: Double
}

struct PointsResponse: Codable {
    let points: [Point]
}

enum PointsRequestResult {
    case success(response: PointsResponse)
    case failed(message: String)
}
