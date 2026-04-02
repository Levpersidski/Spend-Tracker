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
    
    private let editingTransaction: Transaction?
    
    var navigationTitle: String {
        editingTransaction == nil ? "Новый расход" : "Редактировать"
    }
    
    var isEditing: Bool {
            editingTransaction != nil
        }
    
    var successMessage: String {
        isEditing ? "Трата обновлена!" : "Трата добавлена!"
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
        
        guard let parsedAmount = Int(amount.trimmingCharacters(in: .whitespacesAndNewlines)),
              parsedAmount > 0 else { return }
        
        if let existing = editingTransaction {
            let updated = Transaction(
                id: existing.id,
                title: transactionName.trimmingCharacters(in: .whitespacesAndNewlines),
                amount: parsedAmount,
                currency: selectedCurrency,
                category: selectedCategory,
                date: date
            )
            transactionViewModel.updateTransaction(updated)
            
        } else {
            transactionViewModel.addTransaction(
                title: transactionName.trimmingCharacters(in: .whitespacesAndNewlines),
                amount: parsedAmount,
                currency: selectedCurrency,
                category: selectedCategory,
                date: combineDateWithCurrentTime(date)
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
        showSuccess = false
    }
    
    private func combineDateWithCurrentTime(_ date: Date) -> Date {
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: Date.now)
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        dateComponents.second = timeComponents.second
        return calendar.date(from: dateComponents) ?? date
    }
}
