//
//  MyStockDetailView.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 01/08/25.
//

import Foundation
import SwiftUI

struct MyStockDetailView: View {
    let stockDetail: MyStock
    @StateObject private var viewModel = MyStocksDetailViewModel()
    
    var body: some View {

        VStack(alignment: .leading, spacing: 20){
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text("Error \(error)")
            } else if let detail = viewModel.detail {
                HStack(alignment: .top) {
                    VStack(alignment: .leading){
                        Text("Name")
                        Text("Current Price")
                    }
                    VStack(alignment: .leading) {
                        Text(": \(detail.stockName)")
                        Text(": \(viewModel.detail?.close ?? "-")")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading){
                        Text("Open")
                        Text("High")
                        Text("Low")
                        Text("Close")
                    }
                    VStack(alignment: .trailing) {
                        Text("\(viewModel.detail?.open ?? "-")")
                        Text("\(viewModel.detail?.high ?? "-")")
                        Text("\(viewModel.detail?.low ?? "-")")
                        Text("\(viewModel.detail?.close ?? "-")")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading){
                        Text("Average Price")
                        Text("Available Shares")
                        Text("Invested")
                    }
                    VStack(alignment: .trailing) {
                        Text("\(stockDetail.avgPrice)")
                        Text("\(stockDetail.share) Shares")
                        Text("\(String(format: "%.2f", stockDetail.invested)) USD")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )

            } else {
                Text("No Data")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .onAppear {
            print("✅ Navigated to MyStockDetailView")
        }
        .task {
            await viewModel.getStockDetail(symbol: stockDetail.name)
        }
        .navigationTitle("Stock Detail")
    }
}


