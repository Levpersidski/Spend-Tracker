//
//  Currency.swift
//  Spend Tracker
//
//  Created by SWIFT on 30.03.2026.
//





enum Currency: String, CaseIterable {
    case ruble = "₽"
    case dollar = "$"
    case euro = "€"
    
    var title: String {
        switch self {
        case .ruble: return "Рубль"
        case .dollar: return "Доллар"
        case .euro: return "Евро"
        }
    }
    
    var code: String {
        switch self {
        case .ruble: return "RUB"
        case .dollar: return "USD"
        case .euro: return "EUR"
        }
    }
}
