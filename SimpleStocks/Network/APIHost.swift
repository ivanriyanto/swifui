//
//  APIHost.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 03/07/25.
//

import Foundation

enum APIHost {
    static let baseURL = "https://api.twelvedata.com"
    static let apiKey = Bundle.main.twelveDataAPIKey
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

enum APIError: Error {
    case invalidURL
    case decodingFailed(Error)
    case serverError(status: Int)
}
