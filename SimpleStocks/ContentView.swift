////
////  ContentView.swift
////  SimpleStocks
////
////  Created by Ivan Riyanto on 24/06/25.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @StateObject private var viewModel = StocksViewModel()
//    @State private var symbol = "AAPL"
//
//    var body: some View {
//
//        NavigationStack {
//            VStack(spacing: 12) {
//                ForEach(viewModel.stocks) { stock in
//                    StockCardView(name: stock.name, currPrice: 1000, currStat: .bullish)
//                }
//            }
//            .padding()
//            .navigationTitle("Stocks")
//            .toolbar {
//                Button("Add") {
//                    viewModel.addStock(name: "PGEO", price: 1350, stat: .bearish)
//                }
//            }
//        }
//
//    }
//
//}
//
//struct StockCardView: View {
//    let name: String
//    let currPrice: Int
//    let currStat: MarketStatus
//
//    var body: some View {
//        HStack{
//            VStack {
//                Text(name)
//                    .font(.headline)
//                Text(String(currPrice))
//            }
//            Text(currStat.rawValue)
//        }
//        .padding()
//        .background(Color.gray.opacity(0.1))
//        .cornerRadius(10)
//    }
//}
//
//
//
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = StocksViewModel()
    @State private var symbol = "AAPL"
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter Symbol", text: $symbol)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text("Price: \(viewModel.price)")
                    .font(.title)
            }
            
            if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
            
            Button("Fetch Price") {
                Task {
                    await viewModel.getStockPrice(symbol: symbol)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
