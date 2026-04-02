//
//  SuccessOverlay.swift
//  Spend Tracker
//
//  Created by SWIFT on 02.04.2026.
//

import SwiftUI

struct SuccessOverlay: View {
    
    let message: String
    @Binding var animate: Bool
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.green)
                
                Text(message)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground).opacity(0.8))
            )
            .scaleEffect(animate ? 1.0 : 0.5)
            .opacity(animate ? 1.0 : 0)
            .animation(.spring(), value: animate)
        }
        .onAppear {
            withAnimation(.spring()) {
                animate = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                onComplete()
            }
        }
    }
}

#Preview {
    SuccessOverlay(
        message: "Трата добавлена!",
        animate: .constant(true),
        onComplete: { }
    )
}
