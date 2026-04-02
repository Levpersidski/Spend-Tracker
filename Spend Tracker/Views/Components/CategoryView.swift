//
//  CategoryView.swift
//  Spend Tracker
//
//  Created by SWIFT on 21.03.2026.
//

import SwiftUI

struct CategoryView: View {
    @Environment(TransactionViewModel.self) var viewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("По категориям")
                    .font(.system(size: 15, weight: .medium))
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(
                        viewModel.topCategoriesThisMonth,
                        id: \.self
                    ) { category in
                        let total = viewModel.totalAmountForCurrentMonth(for: category)
                        let isEmpty = total == 0
                        
                        VStack(spacing: 6) {
                            Text(category.emoji)
                                .font(.system(size: 26))
                            
                            Text(category.title)
                                .font(.system(size: 13))
                                .foregroundStyle(category.color)
                            
                            Text("\(total) ₽")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(category.color)
                        }
                        .frame(width: 85, height: 85)
                        .background(category.color.opacity(isEmpty ? 0.1 : 0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .opacity(isEmpty ? 0.4 : 1.0)
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryView()
        .environment(TransactionViewModel())
}
