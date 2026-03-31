//
//  TransactionEntity.swift
//  Spend Tracker
//
//  Created by SWIFT on 30.03.2026.
//

import CoreData

@objc(TransactionEntity)
public class TransactionEntity: NSManagedObject {
    
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var amount: Int64
    @NSManaged public var currency: String
    @NSManaged public var category: String
    @NSManaged public var date: Date
    
    static func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }
}
