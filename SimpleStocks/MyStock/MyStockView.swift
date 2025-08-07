//
//  MyStockView.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 25/07/25.
//

import SwiftUI

struct MyStockView: View {
    @StateObject private var viewModel = MyStocksViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    
                    List(viewModel.myStock, id: \.self) { stock in
                        NavigationLink(destination: MyStockDetailView(stockDetail: stock)) {
                            HStack {
                                Text(stock.name)
                                    .frame(width: 50, alignment: .leading)
                                    .font(.headline)
                                VStack(alignment: .leading) {
                                    Text("\(stock.avgPrice) USD")
                                    Text("\(stock.share) Shares")
                                }
                            }
                        }
                    }
                    
                }
            }
            .task {
                await viewModel.getMyStock()
            }
            .navigationTitle("MyStock")
        }
    }
    
}


