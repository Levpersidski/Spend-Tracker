//
//  TransactionRepository.swift
//  Spend Tracker
//
//  Created by SWIFT on 30.03.2026.
//


import CoreData

final class TransactionRepository {
    
    private let manager = CoreDataManager.shared
    
    func fetchAll() -> [Transaction] {
        let request = TransactionEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let entities = try manager.context.fetch(request)
            return entities.map { $0.toTransaction() }
        } catch {
            print("Ошибка загрузки: \(error)")
            return []
        }
    }
    
    func add(_ transaction: Transaction) {
        TransactionEntity.toEntity(transaction, context: manager.context)
        manager.save()
    }
    
    
    func update(_ transaction: Transaction) {
        let request = TransactionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", transaction.id as CVarArg)
        
        do {
               let entities = try manager.context.fetch(request)
               guard let entity = entities.first else { return }
               entity.title = transaction.title
               entity.amount = Int64(transaction.amount)
               entity.currency = transaction.currency.rawValue
               entity.category = transaction.category.rawValue
               entity.date = transaction.date
               manager.save()
            
           } catch {
               print("Ошибка обновления: \(error)")
           }
    }
    
    func delete(_ transaction: Transaction) {
        let request = TransactionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", transaction.id as CVarArg)
        
        do {
            let entities = try manager.context.fetch(request)
            entities.forEach { manager.context.delete($0) }
            manager.save()
        } catch {
            print("Ошибка удаления: \(error)")
        }
    }
    
    func deleteAll() {
        let request = TransactionEntity.fetchRequest()
        do {
            let entities = try manager.context.fetch(request)
            entities.forEach { manager.context.delete($0) }
            manager.save()
        } catch {
            print("Ошибка удаления всех: \(error)")
        }
    }
}
