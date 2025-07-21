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

    private let apiServices = MockAPIServices()
    
    func getStockPrice(symbol: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await apiServices.fetchPrice(for: symbol)
            price = String(result.price)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

