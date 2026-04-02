//
//  TransactionRepositoryProtocol.swift
//  Spend Tracker
//
//  Created by SWIFT on 01.04.2026.
//


import Foundation

protocol TransactionRepositoryProtocol {
    func fetchAll() -> [Transaction]
    func add(_ transaction: Transaction)
    func update(_ transaction: Transaction)
    func delete(_ transaction: Transaction)
    func deleteAll()
}
