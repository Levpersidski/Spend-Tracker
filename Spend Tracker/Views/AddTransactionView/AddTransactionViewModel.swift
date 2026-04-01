//
//  AddTransactionViewModel.swift
//  Spend Tracker
//
//  Created by SWIFT on 31.03.2026.
//

import Observation
import Foundation


@Observable final class AddTransactionViewModel {
    
    var transactionName = ""
    var amount = ""
    var selectedCurrency = Currency.ruble
    var selectedCategory = Category.food
    var date = Date.now
    
    var showSuccess: Bool = false
    // Режим — новая или редактирование
    private let editingTransaction: Transaction?
    
    var navigationTitle: String {
        editingTransaction == nil ? "Новый расход" : "Редактировать"
    }
    
    var isEditing: Bool {
            editingTransaction != nil
        }
    
    var isFormValid: Bool {
        let trimmedTitle = transactionName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let value = Int(amount.trimmingCharacters(in: .whitespacesAndNewlines)) else {return false}
        return !trimmedTitle.isEmpty && value > 0
    }
    
    init(editingTransaction: Transaction? = nil) {
        self.editingTransaction = editingTransaction
        setupFields()
    }
    
    // MARK: - Actions
    
    func save(transactionViewModel: TransactionViewModel) {
        if let existing = editingTransaction {
            let updated = Transaction(
                id: existing.id,
                title: transactionName,
                amount: Int(amount) ?? 0,
                currency: selectedCurrency,
                category: selectedCategory,
                date: date
            )
            transactionViewModel.updateTransaction(updated)
            
        } else {
            transactionViewModel.addTransaction(
                title: transactionName,
                amount: Int(amount) ?? 0,
                currency: selectedCurrency,
                category: selectedCategory,
                date: dateWithCurrentTime(date)
            )
        }
        showSuccess = true
    }
    
    // MARK: - Private
    
    private func setupFields() {
        guard let transaction = editingTransaction else {
            resetFields()
            return
        }
        transactionName = transaction.title
        amount = String(transaction.amount)
        selectedCurrency = transaction.currency
        selectedCategory = transaction.category
        date = transaction.date
    }
    
    func resetIfNeeded() {
        guard editingTransaction == nil else { return }
        resetFields()
    }
    
    private func resetFields() {
        transactionName = ""
        amount = ""
        selectedCurrency = .ruble
        selectedCategory = .food
        date = Date.now
    }
    
    private func dateWithCurrentTime(_ date: Date) -> Date {
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: Date.now)
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        dateComponents.second = timeComponents.second
        return calendar.date(from: dateComponents) ?? date
    }
}
