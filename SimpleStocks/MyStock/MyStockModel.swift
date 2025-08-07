//
//  MyStockModel.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 25/07/25.
//

import Foundation

struct MyStock: Codable, Hashable {
    let name: String
    let avgPrice: String
    let share: Int
    var invested: Double {
        (Double(avgPrice) ?? 0) * Double(share)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case avgPrice
        case share
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        avgPrice = try container.decode(String.self, forKey: .avgPrice)
        share = try container.decode(Int.self, forKey: .share)
    }
    
    init(name: String, avgPrice: String, share: Int) {
        self.name = name
        self.avgPrice = avgPrice
        self.share = share
    }
}
