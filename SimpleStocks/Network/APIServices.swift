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
        return try await request(endpoint, responseType: Stocks.self)
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



