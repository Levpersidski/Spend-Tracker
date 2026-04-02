//
//  TransactionRow.swift
//  Spend Tracker
//
//  Created by SWIFT on 21.03.2026.
//

import SwiftUI

struct TransactionRowView: View {
    
    private var formattedDate: String {
        Self.ruDateFormatter.string(from: date)
    }
    
    private static let ruDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()
    
    
    let color : Color
    let emoji: String
    let title: String
    let currency: String
    let date: Date
    let amount: Int
    
    var body: some View {
        
        
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                Text(emoji)
                    .font(.system(size: 22))
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                Text(formattedDate)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("−\(amount.formatted()) \(currency)")
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color(.pinkAccent))
        }
    }
}

#Preview {
    TransactionRowView(
        color: .amberAccent,
        emoji: Category.food.emoji,
        title: Category.food.title,
        currency: "₽",
        date: Date.now,
        amount: 200
    )
    
    
}
