//
//  CategoryGraphicRow.swift
//  Spend Tracker
//
//  Created by SWIFT on 25.03.2026.
//

import SwiftUI

struct CategoryGraphicRow: View {
    
    let color: Color
    let title: String
    let percent: Double
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            Text(title)
            Spacer()
            Text("\(percent.formatted())%")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    CategoryGraphicRow(color: .red, title: "Кофе", percent: 23)
}
