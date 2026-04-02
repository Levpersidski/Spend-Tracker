//
//  TransactionRepositoryProtocol.swift
//  Spend Tracker
//
//  Created by SWIFT on 01.04.2026.
//


import Foundation

protocol TransactionRepositoryProtocol {
    func fetchAll() throws -> [Transaction]
    func add(_ transaction: Transaction) throws
    func update(_ transaction: Transaction) throws
    func delete(_ transaction: Transaction) throws
    func deleteAll() throws
}
