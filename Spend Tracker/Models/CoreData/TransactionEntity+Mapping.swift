//
//  TransactionEntity+Mapping.swift
//  Spend Tracker
//
//  Created by SWIFT on 30.03.2026.
//

import CoreData

extension TransactionEntity {
    
    func toTransaction() -> Transaction {
        Transaction(
            id: id,
            title: title,
            amount: Int(amount),
            currency: Currency(rawValue: currency) ?? .ruble,
            category: Category(rawValue: category) ?? .food,
            date: date
        )
    }
    
    static func toEntity(_ transaction: Transaction, context: NSManagedObjectContext) {
        let entity = TransactionEntity(context: context)
        entity.id = transaction.id
        entity.title = transaction.title
        entity.amount = Int64(transaction.amount)
        entity.currency = transaction.currency.rawValue
        entity.category = transaction.category.rawValue
        entity.date = transaction.date
        
    }
}
