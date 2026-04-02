//
//  Category.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import Foundation


enum Category: String, CaseIterable, Codable {
    
    case food
    case transport
    case home
    case health
    case entertainment
    case shopping
    case subscriptions
    case other

    
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
}
 
