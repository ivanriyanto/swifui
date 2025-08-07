//
//  Helper.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 04/08/25.
//

import Foundation

func formatToRupiah(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "IDR"
    formatter.maximumFractionDigits = 0
    formatter.locale = Locale(identifier: "id_ID")
    return formatter.string(from: NSNumber(value: value)) ?? "Rp0"
}

