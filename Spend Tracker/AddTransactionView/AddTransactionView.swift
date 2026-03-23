//
//  NewTransactionView.swift
//  Spend Tracker
//
//  Created by SWIFT on 22.03.2026.
//

import SwiftUI

struct AddTransactionView: View {
    
    @State private var selectedCurrency = "₽"
    
    @State private var transactionName = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                SecondaryText(text: "Название")
                CustomTextField(placeholder: "Вкусвилл", text: $transactionName)
                Menu {
                    Button("₽ Рубль") {selectedCurrency = "₽"}
                    Button("$ Доллар") {selectedCurrency = "$"}
                    Button("€ Евро") {selectedCurrency = "€"}
                    
                } label: {
                    Text(selectedCurrency)
                        .padding()
                        .font(.system(.headline, weight:.bold))
                        .background(Color.purpleMain)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
            }
            .padding()
            Spacer()
            
            
                
                
                
                
                
                
                
                    .toolbarBackground(Color(.purpleMain), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .navigationTitle("Новый расход")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarColorScheme(.dark, for: .navigationBar)
            }
            
        }
        
        
    }


#Preview {
    AddTransactionView()
}
