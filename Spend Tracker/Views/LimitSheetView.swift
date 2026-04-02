//
//  LimitSheetView.swift
//  Spend Tracker
//
//  Created by SWIFT on 27.03.2026.
//

import SwiftUI

struct LimitSheetView: View {
    
    @State private var viewModel = LimitSheetViewModel()
    
    let initialValue: Int
    let onSave: (Int) -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Изменить лимит")
                .font(.system(size: 24, weight: .bold))
            
            TextField("Введите лимит", text: $viewModel.limitText)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            
            HStack(spacing: 12) {
                Button("Отмена", action: onCancel)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(.systemGray5))
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                
                Button("Сохранить") {
                    if viewModel.validate() {
                        onSave(viewModel.parsedValue)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.purple)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .disabled(viewModel.canSave)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.setup(initialValue: initialValue)
        }
        
        .alert("Ошибка ввода", isPresented: $viewModel.showAlert) { 
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    LimitSheetView(
        initialValue: 234,
        onSave: {_ in
        },
        onCancel: {})
}
