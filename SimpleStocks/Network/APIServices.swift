//
//  APIServices.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 01/07/25.
//

import Foundation

protocol StocksService {
    func fetchPrice(for symbol: String) async throws -> Stocks
    func fetchUSDtoIDR() async throws -> Stocks
    func fetchStockDetail(for symbol: String) async throws -> MyStockDetailModel
}

protocol MyStocksService {
    func fetchMyStocks() async throws -> [MyStock]
}

struct MockAPIServices: StocksService, MyStocksService {
    func fetchPrice(for symbol: String) async throws -> Stocks {
        try await Task.sleep(nanoseconds: 1000000000)
        return Stocks(name: "AAPL", price: "0")
    }
    
    func fetchStockDetail(for symbol: String) async throws -> MyStockDetailModel {
        try await Task.sleep(nanoseconds: 1000000000)
        return MyStockDetailModel(stockSymbol: "AAPL",
                                  stockName: "Apple Inc.",
                                  open: "203.39999",
                                  high: "205.34000",
                                  low: "202.16000",
                                  close: "202.92000")
    }
    func fetchUSDtoIDR() async throws -> Stocks {
        try await Task.sleep(nanoseconds: 1000000000)
        return Stocks(name: "USD/IDR", price: "16200")
    }
    
    func fetchMyStocks() async throws -> [MyStock] {
        return [MyStock(name: "AAPL", avgPrice: "198", share: 10),
                MyStock(name: "NVDA", avgPrice: "250", share: 8),
                MyStock(name: "TSLA", avgPrice: "300", share: 35)]
    }

}

struct APIServices: StocksService, MyStocksService {
    func fetchStockDetail(for symbol: String) async throws -> MyStockDetailModel {
        let endpoint = Endpoint.quote(symbol: symbol)
        return try await request(endpoint, responseType: MyStockDetailModel.self)
    }
    
    func fetchUSDtoIDR() async throws -> Stocks {
        let endpoint = Endpoint.price(symbol: "USD/IDR")
        return try await request(endpoint, responseType: Stocks.self)
    }
    
    func fetchPrice(for symbol: String) async throws -> Stocks {
        let endpoint = Endpoint.price(symbol: symbol)
        return try await request(endpoint, responseType: Stocks.self)
    }

    func fetchMyStocks() async throws -> [MyStock] {
        // Real APIService request here
        return []
    }

}



extension APIServices {
    private func request<T: Decodable>(_ endpoint: Endpoint, method: HTTPMethod = .GET, responseType: T.Type) async throws -> T {
        guard var components = URLComponents(string: APIHost.baseURL + endpoint.path) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = endpoint.queryItems
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 15
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("Requesting from: \(url)")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(status: httpResponse.statusCode)
        }

        
        print("Raw: \(String(data: data, encoding: .utf8) ?? "Unreadable")")
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw APIError.decodingFailed(error)
        }
    }
}



