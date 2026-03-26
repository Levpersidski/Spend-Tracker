//
//  TransactionViewModel.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import Foundation
import Observation

@Observable class TransactionViewModel {
    
    var transactions = Transaction.getTransactionList()
    
    
    var sortedTransactions: [Transaction] {
        transactions.sorted { $0.date > $1.date }
    }
    
    
    func addTransaction( title: String, amount: Double, currency: String, category: Category, date: Date) {
        
        let newTransaction = Transaction(
            title: title,
            amount: amount,
            currency: currency,
            category: category,
            date: date
        )
        transactions.append(newTransaction)
        
    }
    
    func totalExpenses(for period: Period) -> Double {
        transactionsByPeriod(period).reduce(0) { $0 + $1.amount }
    }
    
    
    func expensesByCategory(for period: Period) -> [(category: Category, total: Double, percent: Double)] {
        let filtered = transactionsByPeriod(period)
        let total = filtered.reduce(0) { $0 + $1.amount }
        
        return Dictionary(grouping: filtered, by: \.category)
            .mapValues { $0.reduce(0) { $0 + $1.amount } }
            .map { (
                category: $0.key,
                total: $0.value,
                percent: total == 0 ? 0 : (($0.value / total) * 100).rounded()
            )}
            .sorted { $0.total > $1.total }
    }

    func expensesByDay(for period: Period) -> [(weekDay: String, total: Double, isMax: Bool)] {
        let filtered = transactionsByPeriod(period)
        let grouped = Dictionary(grouping: filtered, by: { 
            Calendar.current.component(.weekday, from: $0.date)
        })
        .mapValues { items in items.reduce(0) { $0 + $1.amount } }
        
        let maxAmount = grouped.values.max() ?? 0
        let dayKeys = [2, 3, 4, 5, 6, 7, 1]
        
        return dayKeys.map { key in
            let name = ["2":"Пн", "3":"Вт", "4":"Ср", "5":"Чт", "6":"Пт", "7":"Сб", "1":"Вс"][key.description] ?? "???"
            let amount = grouped[key] ?? 0
            return (weekDay: name, total: amount, isMax: amount == maxAmount)
        }
    }
    
    func transactionsByPeriod(_ period: Period) -> [Transaction] {
        let cutoffDate: Date
        switch period {
        case .weak:
            cutoffDate = Calendar.current.date(byAdding: .day, value: -7, to: .now) ?? .now
        case .month:
            cutoffDate = Calendar.current.date(byAdding: .month, value: -1, to: .now) ?? .now
        case .year:
            cutoffDate = Calendar.current.date(byAdding: .year, value: -1, to: .now) ?? .now
        }
        return transactions
            .filter { $0.date >= cutoffDate }
            .sorted { $0.date > $1.date }
    }
}
