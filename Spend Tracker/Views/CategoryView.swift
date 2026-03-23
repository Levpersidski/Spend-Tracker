//
//  CategoryView.swift
//  Spend Tracker
//
//  Created by SWIFT on 21.03.2026.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
       
            HStack {
                Text("По категориям",)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.purpleMain)
                Spacer()
            }
            
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Category.allCases, id: \.self) { category in
                    VStack(spacing: 6) {
                        Text(category.emoji)
                            .font(.system(size: 26))
                        Text(category.title)
                            .font(.system(size: 11))
                            .foregroundStyle(category.color)
                        Text("5 400 ₽")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(category.color)
                    }
                    .frame(width: 85, height: 85)
                    .background(category.color.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
        }  
        
    }
    
}

#Preview {
    CategoryView()
}
