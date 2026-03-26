//
//  NewTransactionView.swift
//  Spend Tracker
//
//  Created by SWIFT on 22.03.2026.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(TransactionViewModel.self) var viewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedCurrency = "₽"
    @State private var transactionName = ""
    @State private var amount = ""
    @State private var selectedCategory = Category.food
    @State private var date = Date.now
    @State private var showDatePicker = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                SecondaryText(text: "Название")
                CustomTextField(placeholder: "Вкусвилл", text: $transactionName)
                
                SecondaryText(text: "Сумма")
                    .padding(.top)
                
                HStack {
                    
                        Menu {
                            Button("₽ Рубль") {selectedCurrency = "₽"}
                            Button("$ Доллар") {selectedCurrency = "$"}
                            Button("€ Евро") {selectedCurrency = "€"}
                            
                        } label: {
                            Text(selectedCurrency)
                                
                                .frame(width: 35, height: 40)
                                .font(.system(.headline, weight:.bold))
                                .background(Color.purpleMain)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                    
                   
                    CustomTextField(placeholder: "Сумма", text: $amount)
                        .keyboardType(.decimalPad)
                }
                SecondaryText(text: "Категория")
                    .padding(.top)
                LazyVGrid(
                    columns: [GridItem(), GridItem(), GridItem()],spacing: 12 ) {
                        ForEach(Category.allCases, id: \.self) { category in
                            VStack(spacing: 6) {
                                Text(category.emoji)
                                    .font(.system(size: 24))
                                Text(category.title)
                                    .font(.system(size: 11))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                selectedCategory == category ? Color.purpleMain : category.color.opacity(0.1)
                            )
                            .foregroundStyle(selectedCategory == category ? .white : category.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .onTapGesture {
                                selectedCategory = category
                            }
                        }
                    }
                SecondaryText(text: "Дата")
                    .padding(.top)
                
                CustomDatePicker(date: $date)
                
                HStack {
                    
                    Button{
                        viewModel.addTransaction(
                            title: transactionName,
                            amount: Double(amount) ?? 0.0,
                            currency: selectedCurrency,
                            category: selectedCategory,
                            date: date
                        )
                        dismiss()
                        
                    } label: {
                        Text("Сохранить")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.purpleMain)
                            .tint(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.top)
                    
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
        .environment(TransactionViewModel())
}
