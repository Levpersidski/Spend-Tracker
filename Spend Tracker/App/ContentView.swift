//
//  ContentView.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            TransactionView()
                .tabItem {
                    Image("homeTabIcon")
                    Text("Главная")
                }
                .tag(0)
            
            NavigationStack {
                AddTransactionView(selectedTab: $selectedTab)
            }
            .tabItem {
                Image("plusPurple")
                Text("Добавить")
            }
            .tag(1)
            
            StatisticsView()
                .tabItem {
                    Image("staticsChart")
                    Text("Статистика")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Image("colorGear")
                    Text("Настройки")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
        .environment(TransactionViewModel())
        .environment(SettingsViewModel())
}
