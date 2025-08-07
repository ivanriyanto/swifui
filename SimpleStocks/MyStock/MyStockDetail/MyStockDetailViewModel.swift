//
//  MyStockDetailViewModel.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 01/08/25.
//

import Foundation

@MainActor
class MyStocksDetailViewModel: ObservableObject {
    @Published var detail: MyStockDetailModel?
    @Published var isLoading = false
    @Published var errorMessage: String?

    //private let apiServices = MockAPIServices()
    private let apiServices = APIServices()
    
    
    //Same function from MyStockViewModel, can be simplified by creating its own class
    func getStockDetail(symbol: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await apiServices.fetchStockDetail(for: symbol)
            detail = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
