//
//  TransactionRepository.swift
//  Spend Tracker
//
//  Created by SWIFT on 30.03.2026.
//


import CoreData

final class TransactionRepository: TransactionRepositoryProtocol {
    
    private let manager = CoreDataManager.shared
    
    func fetchAll() throws -> [Transaction] {
        let request = TransactionEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let entities = try manager.context.fetch(request)
            return entities.map { $0.toTransaction() }
        } catch {
            throw AppError.fetchFailed
        }
    }
    
    func add(_ transaction: Transaction) throws {
        TransactionEntity.insert(from: transaction, into: manager.context)
        do {
            try  manager.save()
        } catch {
            throw AppError.saveFailed
        }
    }
    
    
    func update(_ transaction: Transaction) throws {
        
        guard let entity = try fetchEntity(by: transaction.id) else { return }
        entity.title = transaction.title
        entity.amount = Int64(transaction.amount)
        entity.currency = transaction.currency.rawValue
        entity.category = transaction.category.rawValue
        entity.date = transaction.date
        do {
            try manager.save() 
        } catch {
            throw AppError.saveFailed
        }
    }
    
    func delete(_ transaction: Transaction) throws {
        guard let entity = try fetchEntity(by: transaction.id) else { return }
        manager.context.delete(entity)
        do {
           try manager.save()    
        } catch {
            throw AppError.deleteFailed
        }
    }
    func deleteAll() throws {
        let request = TransactionEntity.fetchRequest()
        do {
            let entities = try manager.context.fetch(request)
            entities.forEach { manager.context.delete($0) }
           try manager.save()
        } catch {
            throw AppError.deleteFailed
        }
    }
    
    private func fetchEntity(by id: UUID) throws -> TransactionEntity? {
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
