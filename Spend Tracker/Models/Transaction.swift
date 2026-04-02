//
//  Transaction.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import Foundation


struct Transaction: Identifiable, Equatable {
    let id: UUID
    let title: String
    let amount: Int
    let currency: Currency
    let category: Category
    let date: Date
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.id == rhs.id
    }
    
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
}







