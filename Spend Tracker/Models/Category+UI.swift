//
//  Category+UI.swift
//  Spend Tracker
//
//  Created by SWIFT on 01.04.2026.
//

import SwiftUI

extension Category {
    
    var color: Color {
        switch self {
        case .food: .amberAccent
        case .transport: .blue
        case .home: .indigo
        case .health: .greenAccent
        case .entertainment: .pinkAccent
        case .shopping: .brown
        case .subscriptions: .lightPurple
        case .other: Color(.systemGray4)
        }
    }
}
