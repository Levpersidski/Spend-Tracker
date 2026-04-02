//
//  TransactionRepository.swift
//  Spend Tracker
//
//  Created by SWIFT on 30.03.2026.
//


import CoreData

final class TransactionRepository: TransactionRepositoryProtocol {
    
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
        TransactionEntity.insert(from: transaction, into: manager.context)
        manager.save()
    }
    
    
    func update(_ transaction: Transaction) {
        
        guard let entity = fetchEntity(by: transaction.id) else { return }
        entity.title = transaction.title
        entity.amount = Int64(transaction.amount)
        entity.currency = transaction.currency.rawValue
        entity.category = transaction.category.rawValue
        entity.date = transaction.date
        manager.save()
    }
    
    func delete(_ transaction: Transaction) {
        guard let entity = fetchEntity(by: transaction.id) else { return }
        manager.context.delete(entity)
        manager.save()    
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
    
    private func fetchEntity(by id: UUID) -> TransactionEntity? {
        let request = TransactionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try manager.context.fetch(request).first
        } catch {
            print("Ошибка поиска: \(error)")
            return nil
        }
    }
}
