//
//  Category.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import SwiftUI



enum Category: CaseIterable {
    
    case food
    case transport
    case fun
    case health
    case coffee
    case other
    
   
    
    var title: String {
        
        switch self {
        case .food: "Еда"
        case .transport: "Транспорт"
        case .fun: "Развлечения"
        case .health: "Здоровье"
        case .coffee: "Кофе"
        case .other: "Другое"
            
        }
    }
    
    var emoji: String {
        
        switch self {
            
        case .food: "🍕"
        case .transport: "🚗"
        case .fun: "🎮"
        case .health: "❤️"
        case .coffee: "☕️"
        case .other: "📦"

        }
        
    }
    
    var color: Color {
            switch self {
            case .food: .purpleMain
            case .transport: .pinkAccent
            case .fun: .greenAccent
            case .health: .amberAccent
            case .coffee: .brown
            case .other: Color(.systemGray4)
            }
        }

}

 
