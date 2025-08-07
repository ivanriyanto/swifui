//
//  MyStockDetailModel.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 01/08/25.
//

import Foundation

struct MyStockDetailModel: Codable, Hashable {
    let stockSymbol: String
    let stockName: String
    let open: String
    let high: String
    let low: String
    let close: String
    
    enum CodingKeys: String, CodingKey {
        case stockSymbol = "symbol"
        case stockName = "name"
        case open
        case high
        case low
        case close
    }
    
    init(stockSymbol: String,
         stockName: String,
         open: String,
         high: String,
         low: String,
         close: String) {
        self.stockSymbol = stockSymbol
        self.stockName = stockName
        self.open = open
        self.high = high
        self.low = low
        self.close = close
    }
}

//
//{
//    "symbol": "AAPL",
//    "name": "Apple Inc",
//    "exchange": "NASDAQ",
//    "mic_code": "XNAS",
//    "currency": "USD",
//    "datetime": "2021-09-16",
//    "timestamp": 1631772000,
//    "last_quote_at": 1631772000,
//    "open": "148.44000",
//    "high": "148.96840",
//    "low": "147.22099",
//    "close": "148.85001",
//    "volume": "67903927",
//    "previous_close": "149.09000",
//    "change": "-0.23999",
//    "percent_change": "-0.16097",
//    "average_volume": "83571571",
//    "rolling_1day_change": "123.123",
//    "rolling_7day_change": "123.123",
//    "rolling_period_change": "123.123",
//    "is_market_open": false,
//    "fifty_two_week": {
//        "low": "103.10000",
//        "high": "157.25999",
//        "low_change": "45.75001",
//        "high_change": "-8.40999",
//        "low_change_percent": "44.37440",
//        "high_change_percent": "-5.34782",
//        "range": "103.099998 - 157.259995"
//    },
//    "extended_change": "0.09",
//    "extended_percent_change": "0.05",
//    "extended_price": "125.22",
//    "extended_timestamp": "1649845281"
//}

