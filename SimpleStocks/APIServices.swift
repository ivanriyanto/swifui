//
//  APIServices.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 01/07/25.
//

import Foundation

enum APIHost {
    static let baseURL = "https://api.twelvedata.com"
}

enum EndPoint {
    static let price = "/price"
}

struct APIServices {
    let apiKey = Bundle.main.twelveDataAPIKey
    
    func fetchPrice(for symbol: String) async throws -> Stocks {
        guard var components = URLComponents(string: "\(APIHost.baseURL)\(EndPoint.price)") else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "symbol", value: symbol),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        
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
            print("❌ Error decoding: \(error)")
            throw error
        }
        
        
    }
}


