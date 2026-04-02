//
//  Currency.swift
//  Spend Tracker
//
//  Created by SWIFT on 30.03.2026.
//



import Foundation 

enum Currency: String, CaseIterable, Codable {
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
}
