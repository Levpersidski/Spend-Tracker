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
}
