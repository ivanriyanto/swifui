//
//  ContentViewModel.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 26/06/25.
//

import Foundation
import SwiftUI

@MainActor
class StocksViewModel: ObservableObject {
    @Published var price: String = "-"
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var idrPrice: String = "-"
    

    private let apiServices = MockAPIServices()
    //private let apiServices = APIServices()
    
    func getStockPrice(symbol: String) async -> Double {
        do {
            let result = try await apiServices.fetchPrice(for: symbol)
            if let priceDouble = Double(result.price) {
                return priceDouble
            } else {
                errorMessage = "Invalid price format"
                return 0
            }
        } catch {
            errorMessage = error.localizedDescription
            return 0
        }
    }
    
    func getUSDtoIDR() async -> Double {
        do {
            let result = try await apiServices.fetchUSDtoIDR()
            if let priceDouble = Double(result.price) {
                return priceDouble
            } else {
                errorMessage = "Invalid exchange rate format"
                return 0
            }
        } catch {
            errorMessage = error.localizedDescription
            return 0
        }
    }
}

