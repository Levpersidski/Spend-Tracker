//
//  SpendingView.swift
//  Spend Tracker
//
//  Created by SWIFT on 21.03.2026.
//

import SwiftUI

struct SpendingView: View {
    
    
    var body: some View {
    
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white.opacity(0.18))
                    .frame(height: 100)
                    .overlay(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Расходы за март")
                                .font(.system(size: 12))
                                .foregroundStyle(.white.opacity(0.8))
                            Text("₽ 24 850")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(.white)
                            ProgressView(value: 0.65)
                                .tint(.yellow)
                            Text("Лимит: ₽ 40 000 · осталось ₽ 15 150")
                                .font(.system(size: 11))
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        .padding()
                    }
            
        
    }
}

#Preview {
    SpendingView()
}
