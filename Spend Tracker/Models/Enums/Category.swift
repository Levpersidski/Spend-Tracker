//
//  Category.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import SwiftUI


enum Category: String, CaseIterable {
    
    case food = "food"
    case transport = "transport"
    case home = "home"
    case health = "health"
    case entertainment = "entertainment"
    case shopping = "shopping"
    case subscriptions = "subscriptions"
    case other = "other"
    
    var title: String {
        switch self {
        case .food: "Еда"
        case .transport: "Транспорт"
        case .home: "Дом"
        case .health: "Здоровье"
        case .entertainment: "Развлечения"
        case .shopping: "Покупки"
        case .subscriptions: "Подписки"
        case .other: "Другое"
        }
    }
    
    var emoji: String {
        switch self {
        case .food: "🍔"
        case .transport: "🚕"
        case .home: "🏠"
        case .health: "💊"
        case .entertainment: "🎉"
        case .shopping: "🛍️"
        case .subscriptions: "📱"
        case .other: "📦"
        }
    }
    
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
 
