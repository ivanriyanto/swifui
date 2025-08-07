//
//  ContentView.swift
//  SimpleStocks
//
//  Created by Ivan Riyanto on 25/07/25.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            MyStockView()
                .tabItem{
                    Label("MyStocks", systemImage: "chart.bar")
                }
            
        }
    }
}


