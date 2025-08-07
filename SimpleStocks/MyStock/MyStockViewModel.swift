//
//  MyStockViewModel.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 25/07/25.
//

import Foundation

@MainActor
class MyStocksViewModel: ObservableObject {
    @Published var myStock: [MyStock] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiServices = MockAPIServices()
    //private let apiServices = APIServices()
    
    func getMyStock() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await apiServices.fetchMyStocks()
            myStock = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
