//
//  APIServices.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 01/07/25.
//

import Foundation

protocol StocksService {
    func fetchPrice(for symbol: String) async throws -> Stocks
}

struct MockAPIServices: StocksService {
    func fetchPrice(for symbol: String) async throws -> Stocks {
        try await Task.sleep(nanoseconds: 1000000000)
        if symbol == "AAPL" {
            return Stocks(name: "AAPL", price: "209")
        } else if symbol == "NVDA" {
            return Stocks(name: "AAPL", price: "144")
        } else {
            return Stocks(name: "AAPL", price: "0")
        }
        
    }
}

struct APIServices: StocksService {
    let key = APIHost.apiKey
    
    func fetchPrice(for symbol: String) async throws -> Stocks {
        let endpoint = Endpoint.price(symbol: symbol)
        guard var components = URLComponents(string: APIHost.baseURL + endpoint.path) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = endpoint.queryItems
        
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        print("url \(url)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            print("RAW RESPONSE:\n", String(data: data, encoding: .utf8) ?? "Invalid Data")
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            return try JSONDecoder().decode(Stocks.self, from: data)
        } catch {
            print("Error decoding: \(error)")
            throw error
        }
        
        
    }
}


