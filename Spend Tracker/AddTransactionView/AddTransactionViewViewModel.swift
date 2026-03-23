//
//  AddTransactionViewViewModel.swift
//  Spend Tracker
//
//  Created by SWIFT on 22.03.2026.
//


import Foundation
import  Observation

@Observable final class TransactionViewViewModel {
    
    var transactions = Transaction.getTransactionList()
    
    let nameTransaction = ""
    let amount = 0.0
//    let category: Category
//    let date: Date
    
//    func addTransaction() {
//        
//        let transaction = Transaction(
//            id: 5,
//            title: nameTransaction,
//            amount: amount,
//            category: category,
//            date: date
//        )
//        transactions.append(transaction)
//    }
    
}
