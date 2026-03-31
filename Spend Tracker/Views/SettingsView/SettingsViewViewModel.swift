//
//  SettingsViewViewModel.swift
//  Spend Tracker
//
//  Created by SWIFT on 29.03.2026.
//


import Foundation
import Observation

@Observable final class SettingsViewViewModel {
    

    
    // MARK: - Keys
    private enum Keys {
        static let monthlyLimit = "monthlyLimit"
        static let reminder = "reminder"
    }
    
    var isReminderEnabled: Bool = UserDefaults.standard.bool(
        forKey: Keys.reminder
    )

        
    // MARK: - State
    var monthlyLimit: Int = 40000
    var showLimitSheet: Bool = false
    
    // MARK: - Init
    init() {
        restore() 
    }
    
    // MARK: - Persistence
    private func restore() {
        let saved = UserDefaults.standard.integer(forKey: Keys.monthlyLimit)
        monthlyLimit = saved == 0 ? 40000 : saved  
    }
    
    func saveReminder(_ value: Bool) {
        isReminderEnabled = value
        UserDefaults.standard.set(value, forKey: Keys.reminder)
    }

    func deleteAllTransactions(transactionViewModel: TransactionViewModel) {
        transactionViewModel.deleteAll()
    }
    
    private func persist() {
        UserDefaults.standard.set(monthlyLimit, forKey: Keys.monthlyLimit)
    }
    
    // MARK: - Actions
    func openLimitSheet() {
        showLimitSheet = true
    }
    
    func closeLimitSheet() {
        showLimitSheet = false
    }
    
    func applyNewLimit(_ value: Int) {
        monthlyLimit = value
        persist()
        showLimitSheet = false
    }
}
