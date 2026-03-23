//
//  Transaction.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import Foundation


struct Transaction: Identifiable {
    let id: UUID = UUID()
    let title: String
    let amount: Double
    let currency: String
    let category: Category
    let date: Date
    
    
    static func getTransactionList() -> [Transaction] {
        return [
            Transaction( title: "Молоко", amount: 242, currency: "₽", category: .food, date: .now),
            Transaction(title: "Хлеб", amount: 120, currency: "₽", category: .food, date: .now),
            Transaction(title: "Такси", amount: 242, currency: "₽", category: .transport, date: .now),
            Transaction(title: "Кардиолог", amount: 1000, currency: "₽" , category: .health, date: .now),
            Transaction(title: "Кино", amount: 5200, currency: "₽", category: .fun, date: .now),
            Transaction(title: "Спортзал", amount: 3000, currency: "₽", category: .other, date: .now)
        ]
    }
    
}







