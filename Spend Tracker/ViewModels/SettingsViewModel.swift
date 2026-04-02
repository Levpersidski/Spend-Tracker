//
//  SettingsViewViewModel.swift
//  Spend Tracker
//
//  Created by SWIFT on 29.03.2026.
//


import Foundation
import Observation

@Observable final class SettingsViewModel {
    
    private static let defaultLimit = 40000
    
    private enum Keys {
        static let monthlyLimit = "monthlyLimit"
        static let reminder = "reminder"
    }
    
    var monthlyLimit = SettingsViewModel.defaultLimit
    var showLimitSheet = false
    
    var isReminderEnabled: Bool = UserDefaults.standard.bool(forKey: Keys.reminder)
    
    var cSVFileURL: URL?
    var showShareSheet = false
    
    init() {
        restoreLimit() 
    }
    
    
    private func restoreLimit() {
        let saved = UserDefaults.standard.integer(forKey: Keys.monthlyLimit)
        monthlyLimit = saved == 0 ? 40000 : saved  
    }
    
    private func persistLimit() {
        UserDefaults.standard.set(monthlyLimit, forKey: Keys.monthlyLimit)
    }
    
    func saveReminder(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: Keys.reminder)
    }

    func deleteAllTransactions(transactionViewModel: TransactionViewModel) {
        transactionViewModel.deleteAll()
    }
    
   
    
    // MARK: - Limit Sheet Actions
    
    func openLimitSheet() {
        showLimitSheet = true
    }
    
    func closeLimitSheet() {
        showLimitSheet = false
    }
    
    func applyNewLimit(_ value: Int) {
        monthlyLimit = value
        persistLimit()
        showLimitSheet = false
    }
    
    // MARK: - CSV Export
    
    func exportCSV(transactions: [Transaction]) {
    
        var csv = "Название,Сумма,Валюта,Категория,Дата\n"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        
        for transaction in transactions {
            
            let escapedTitle = transaction.title.replacingOccurrences(of: "\"", with: "\"\"")
            let line = "\"\(escapedTitle)\",\(transaction.amount),\(transaction.currency.rawValue),\(transaction.category.title),\(dateFormatter.string(from: transaction.date))"
            csv += line + "\n"
        }
        
        
        let fileName = "spend_tracker_export.csv"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            let bom = "\u{FEFF}"
            try (bom + csv).write(to: tempURL, atomically: true, encoding: .utf8)
            cSVFileURL = tempURL
            showShareSheet = true
        } catch {
            print("Ошибка экспорта CSV: \(error)")
        }
    }

}
