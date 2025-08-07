//
//  ContentView.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 24/06/25.
//

import SwiftUI

struct HomeView: View {
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
                    async let stockTask = viewModel.getStockPrice(symbol: "AAPL")
                    async let fxTask = viewModel.getUSDtoIDR()

                    let (usdPrice, usdToIdr) = await (stockTask, fxTask)
                    viewModel.price = formatToRupiah(usdPrice * usdToIdr)
                    

                    //print("✅ AAPL price in IDR: Rp\(Int(idrPrice))")
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

