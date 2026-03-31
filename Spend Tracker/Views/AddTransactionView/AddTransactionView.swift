//
//  NewTransactionView.swift
//  Spend Tracker
//
//  Created by SWIFT on 22.03.2026.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(TransactionViewModel.self) var transactionVM
    
    @State private var viewModel: AddTransactionViewModel
    
    @Environment(\.dismiss) var dismiss
    var selectedTab: Binding<Int>? = nil
    
    init(editingTransaction: Transaction? = nil, selectedTab: Binding<Int>? = nil) {
            _viewModel = State(initialValue: AddTransactionViewModel(editingTransaction: editingTransaction))
            self.selectedTab = selectedTab
        }
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                SecondaryText(text: "Название")
                CustomTextField(
                    placeholder: "Вкусвилл",
                    text: $viewModel.transactionName
                )
                
                SecondaryText(text: "Сумма")
                    .padding(.top)
                
                HStack {
                    
                    Menu {
                        ForEach(Currency.allCases, id: \.self) { currency in 
                            Button(currency.title) {
                                
                                viewModel.selectedCurrency = currency}
                        }
                        } label: {
                            Text(viewModel.selectedCurrency.rawValue)
                                
                                .frame(width: 35, height: 40)
                                .font(.system(.headline, weight:.bold))
                                .background(Color.purpleMain)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                    
                   
                    CustomTextField(placeholder: "Сумма", text: $viewModel.amount)
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
                                viewModel.selectedCategory == category ? Color.purpleMain : category.color.opacity(0.1)
                            )
                            .foregroundStyle(viewModel.selectedCategory == category ? .white : category.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .onTapGesture {
                                viewModel.selectedCategory = category
                            }
                        }
                    }
                
                SecondaryText(text: "Дата")
                    .padding(.top)
                
                CustomDatePicker(date: $viewModel.date)
                
                HStack {
                    
                    Button{
                        viewModel.save(transactionViewModel: transactionVM)
                        navigateBack() 
                    } label: {
                        Text("Сохранить")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.purpleMain)
                            .tint(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .disabled(!viewModel.isFormValid)
                .padding(.top)
                    
                    
            }
            .padding()
            Spacer()
        
            
                    .toolbarBackground(Color(.purpleMain), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .onAppear {
                        viewModel.resetIfNeeded()
                    }
                    .navigationTitle(viewModel.navigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarColorScheme(.dark, for: .navigationBar)
            }
            
        }
    private func navigateBack() {
           if let selectedTab {
               selectedTab.wrappedValue = 0
           } else {
               dismiss()
           }
       }
    
    }

#Preview {
    AddTransactionView()
        .environment(TransactionViewModel())
}
