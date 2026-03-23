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
    
    var body: some Scene {
    
        WindowGroup {
            TransactionView()
                .environment(viewModel)
                
        }
    }
}
