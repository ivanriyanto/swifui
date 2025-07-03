//
//  Bundle.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 03/07/25.
//

import Foundation

extension Bundle {
    var twelveDataAPIKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "TWELVE_DATA_API_KEY") as? String else {
            fatalError("API key not found. Did you forget to add it to Info.plist?")
        }
        return key
    }
}
