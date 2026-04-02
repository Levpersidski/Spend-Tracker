//
//  SpendingView.swift
//  Spend Tracker
//
//  Created by SWIFT on 21.03.2026.
//

import SwiftUI

struct SpendingView: View {
    
    @Environment(TransactionViewModel.self) var transactionViewModel
    @Environment(SettingsViewModel.self) var settingsViewModel
    
    private var monthlyExpenses: Int {
        transactionViewModel.totalExpenses(for: .month)
    }
        
    private var monthlyLimit: Int {
        settingsViewModel.monthlyLimit
    }
    
    private var remainder: Int {
        monthlyLimit - monthlyExpenses
    }
    
    private var progress: Double {
        guard monthlyLimit > 0 else { return 0 }
        return min(Double(monthlyExpenses) / Double(monthlyLimit), 1.0)
    }
    
    private var progressColor: Color {
        progress >= 1.0 ? .red : .yellow
    }
    
    private static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL"
        return formatter
    }()
    
    private var currentMonthName: String {
        Self.monthFormatter.string(from: .now)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.white.opacity(0.18))
            .frame(height: 100)
            .overlay(alignment: .leading) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Расходы за \(currentMonthName)")
                        .font(.system(size: 12))
                        .foregroundStyle(.white.opacity(0.8))
                    
                    Text("₽ \(monthlyExpenses.formatted())")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                    
                    ProgressView(value: progress)
                        .tint(progressColor)
                    
                    Text("Лимит: ₽ \(monthlyLimit.formatted()) · осталось ₽ \(remainder.formatted())")
                        .font(.system(size: 11))
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding()
            }
    }
}

#Preview {
    SpendingView()
        .environment(TransactionViewModel())
        .environment(SettingsViewModel())
}
