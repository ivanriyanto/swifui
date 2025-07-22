//
//  Endpoint.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 01/07/25.
//

import Foundation


enum Endpoint {
    case price(symbol: String)

    var path: String {
        switch self {
        case .price: return "/price"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .price(let symbol):
            return [
                URLQueryItem(name: "symbol", value: symbol),
                URLQueryItem(name: "apikey", value: APIHost.apiKey)
            ]
        }
    }
}
