//
//  Transaction.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import Foundation


struct Transaction: Identifiable {
    let id: UUID
    let title: String
    let amount: Int
    let currency: Currency
    let category: Category
    let date: Date
    
    
    static var preview: Transaction {
        Transaction(
            id: UUID(),
            title: "Кино",
            amount: 1300,
            currency: .ruble,
            category: .food,
            date: .now
        )
    }
    
    private static func makeDate(year: Int, month: Int, day: Int) -> Date {
        var c = DateComponents()
        c.year = year
        c.month = month
        c.day = day
        return Calendar.current.date(from: c) ?? .now
    }
    
}







