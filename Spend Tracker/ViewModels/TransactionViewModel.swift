//
//  TransactionViewModel.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import Foundation
import Observation

@Observable
class TransactionViewModel {
    
    var transactions: [Transaction] = []
    
    private let repository: TransactionRepositoryProtocol
    
    var topCategoriesThisMonth: [Category] {
        Category.allCases.sorted { first, second in
            totalAmountForCurrentMonth(for: first) > totalAmountForCurrentMonth(for: second)
        }
    }
    
    var currentMonthTransactions: [Transaction] {
        transactionsByPeriod(.month)
    }
    
    var isCurrentMonthEmpty: Bool {
        currentMonthTransactions.isEmpty
    }
    
    
    init(repository: TransactionRepositoryProtocol = TransactionRepository()) {
        self.repository = repository
        loadTransactions()
    }
    
    func loadTransactions() {
        transactions = repository.fetchAll()
    }
    
    func addTransaction(title: String, amount: Int, currency: Currency, category: Category, date: Date) {
        let transaction = Transaction(
            id: UUID(),
            title: title,
            amount: amount,
            currency: currency,
            category: category,
            date: date
        )
        repository.add(transaction)
        loadTransactions()
    }
    
    func updateTransaction(_ transaction: Transaction) {
        repository.update(transaction)
        loadTransactions()
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        repository.delete(transaction)
        loadTransactions()
    }
    
    func deleteAll() {
        repository.deleteAll()
        loadTransactions()
    }
    
    func totalExpenses(for period: Period) -> Int {
        transactionsByPeriod(period).reduce(0) { $0 + $1.amount }
    }
    
    func totalAmountForCurrentMonth(for category: Category) -> Int {
        currentMonthTransactions
            .filter { $0.category == category }
            .reduce(0) { $0 + $1.amount }
    }
    
    func expensesByCategory(for period: Period) -> [(category: Category, total: Int, percent: Double)] {
        let filtered = transactionsByPeriod(period)
        let total = filtered.reduce(0) { $0 + $1.amount }
        
        return Dictionary(grouping: filtered, by: \.category)
            .mapValues { $0.reduce(0) { $0 + $1.amount } }
            .map {
                (
                    category: $0.key,
                    total: $0.value,
                    percent: total == 0 ? 0 : (Double($0.value) / Double(total) * 100).rounded()
                )
            }
            .sorted { $0.total > $1.total }
    }
    
    func expensesByDay(for period: Period) -> [(weekDay: String, total: Int, isMax: Bool)] {
        let filtered = transactionsByPeriod(period)
        let grouped = Dictionary(grouping: filtered, by: {
            Calendar.current.component(.weekday, from: $0.date)
        })
        .mapValues { items in
            items.reduce(0) { $0 + $1.amount }
        }
        
        let maxAmount = grouped.values.max() ?? 0
        let dayKeys = [2, 3, 4, 5, 6, 7, 1]
        
        return dayKeys.map { key in
            let name = ["2": "Пн", "3": "Вт", "4": "Ср", "5": "Чт", "6": "Пт", "7": "Сб", "1": "Вс"][key.description] ?? "???"
            let amount = grouped[key] ?? 0
            return (weekDay: name, total: amount, isMax: amount == maxAmount)
        }
    }
    
    func transactionsByPeriod(_ period: Period, referenceDate: Date = .now) -> [Transaction]  {
        let calendar = Calendar.current
        
        switch period {
        case .week:
            let cutoffDate = calendar.date(
                byAdding: .day,
                value: -7,
                to: referenceDate
            ) ?? .now
            return transactions
                .filter { $0.date >= cutoffDate }
                .sorted { $0.date > $1.date }
            
        case .month:
            guard let monthInterval = calendar.dateInterval(of: .month, for: referenceDate) else {
                return []
            }
            return transactions
                .filter { monthInterval.contains($0.date) }
                .sorted { $0.date > $1.date }
            
        case .year:
            guard let yearInterval = calendar.dateInterval(of: .year, for: referenceDate) else {
                return []
            }
            return transactions
                .filter { yearInterval.contains($0.date) }
                .sorted { $0.date > $1.date }
        }
    }
}
