//
//  Transaction.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import Foundation


struct Transaction: Identifiable {
    let id: Int?
    let title: String
    let amount: Double
    let category: Category
    let date: Date
    
    
    static func getTransactionList() -> [Transaction] {
        return [
            Transaction(id: 1, title: "Молоко", amount: 242, category: .food, date: .now),
            Transaction(id: 2, title: "Хлеб", amount: 120, category: .food, date: .now),
            Transaction(id: 3, title: "Такси", amount: 242, category: .transport, date: .now),
            Transaction(id: 4, title: "Кардиолог", amount: 1000, category: .health, date: .now),
            Transaction(id: 5, title: "Кино", amount: 5200, category: .fun, date: .now),
            Transaction(id: 6, title: "Спортзал", amount: 3000, category: .other, date: .now),
        ]
    }
    
}







