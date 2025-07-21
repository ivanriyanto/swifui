//
//  ContentModel.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 26/06/25.
//

import Foundation
import SwiftUI

internal enum MarketStatus: String {
    case bullish
    case bearish

    var color: Color {
        switch self {
        case .bullish: return .green
        case .bearish: return .red
        }
    }

}

struct Stocks: Codable {
    let name: String?
    let price: String

    enum CodingKeys: String, CodingKey {
        case name
        case price
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        price = try container.decode(String.self, forKey: .price)
    }
    
    init(name: String?, price: String) {
            self.name = name
            self.price = price
    }
}
