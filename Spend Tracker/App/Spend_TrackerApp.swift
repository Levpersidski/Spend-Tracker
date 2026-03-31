//
//  Spend_TrackerApp.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import SwiftUI

@main
struct Spend_TrackerApp: App {
    
    @State private var viewModel = TransactionViewModel()
    @State private var settingsViewModel = SettingsViewViewModel() 
    
    var body: some Scene {
    
        WindowGroup {
            ContentView()
                .environment(viewModel)
                .environment(settingsViewModel)
        }
    }
}
