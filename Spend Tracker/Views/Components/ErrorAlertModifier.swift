//
//  ErrorAlertModifier.swift
//  Spend Tracker
//
//  Created by SWIFT on 02.04.2026.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    
    @Binding var message: String?
    
    // Конвертируем String? в Bool для .alert(isPresented:)
    private var isPresented: Binding<Bool> {
        Binding(
            get: { message != nil },
            set: { if !$0 { message = nil } }
        )
    }
    
    func body(content: Content) -> some View {
        content
            .alert("Ошибка", isPresented: isPresented) {
                Button("OK", role: .cancel) { }
            } message: {
                if let message {
                    Text(message)
                }
            }
    }
}

// MARK: - Удобное расширение для вызова

extension View {
    func errorAlert(message: Binding<String?>) -> some View {
        modifier(ErrorAlertModifier(message: message))
    }
}
