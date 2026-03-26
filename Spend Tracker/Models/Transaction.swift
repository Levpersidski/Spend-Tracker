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
            Transaction(
                title: "Молоко",
                amount: 700,
                currency: "₽",
                category: .food,
                date: makeDate(year: 2026, month: 3, day: 22)
            ),
            Transaction(
                title: "Пятерочка",
                amount: 1400,
                currency: "₽",
                category: .food,
                date: makeDate(year: 2026, month: 3, day: 24)
            ),
            Transaction(
                title: "Такси",
                amount: 1600,
                currency: "₽",
                category: .transport,
                date: makeDate(year: 2026, month: 3, day: 25)
            ),
            Transaction(
                title: "Кардиолог",
                amount: 3500,
                currency: "₽" ,
                category: .health,
                date: makeDate(year: 2026, month: 3, day: 24)
            ),
            Transaction(
                title: "Аквапарк",
                amount: 10000,
                currency: "₽",
                category: .fun,
                date: makeDate(year: 2026, month: 3, day: 26)
            ),
            Transaction(
                title: "Кино",
                amount: 1300,
                currency: "₽",
                category: .fun,
                date: makeDate(year: 2025, month: 8, day: 23)
            ),
            
            Transaction(
                title: "Кино",
                amount: 1300,
                currency: "₽",
                category: .fun,
                date: makeDate(year: 2025, month: 8, day: 23)
            ),
            Transaction(
                title: "Кино",
                amount: 1300,
                currency: "₽",
                category: .fun,
                date: makeDate(year: 2025, month: 7, day: 11)
            ),
            
            Transaction(
                title: "Кино",
                amount: 1300,
                currency: "₽",
                category: .fun,
                date: makeDate(year: 2026, month: 3, day: 2)
            ),
            
            Transaction(
                title: "Кино",
                amount: 1300,
                currency: "₽",
                category: .fun,
                date: makeDate(year: 2026, month: 3, day: 5)
            ),
            
            Transaction(
                title: "Кино",
                amount: 1300,
                currency: "₽",
                category: .fun,
                date: makeDate(year: 2026, month: 3, day: 8)
            ),

            Transaction(
                title: "Спортзал",
                amount: 2000,
                currency: "₽",
                category: .other,
                date: makeDate(year: 2026, month: 3, day: 22)
            )
        ]
    }
    
    private static func makeDate(year: Int, month: Int, day: Int) -> Date {
        var c = DateComponents()
        c.year = year
        c.month = month
        c.day = day
        return Calendar.current.date(from: c) ?? .now
    }
    
}







