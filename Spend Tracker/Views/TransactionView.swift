//
//  TransactionViewModel.swift
//  Spend Tracker
//
//  Created by SWIFT on 19.03.2026.
//

import SwiftUI

struct TransactionView: View {
    
    @Environment(TransactionViewModel.self) var viewModel
    
    var body: some View {
        
        @Bindable var viewModel = viewModel 
        
        NavigationStack {
            ZStack(alignment: .top) {
                
               
                Color(.purpleMain)
                    .frame(height: 300)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                 
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Мои расходы 💸")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                        
                        SpendingView()
                    }
                    .padding()
                    .padding(.bottom, 40)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        CategoryView()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                            .padding(.bottom)
                        
                        Text("Последние операции")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        List {
                            if viewModel.isCurrentMonthEmpty {
                               
                                HStack {
                                    Spacer()
                                    
                                    Text("В этом месяце нет трат")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.secondary)
                                        .padding(.vertical, 30)
                                    
                                    Spacer()
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                
                            } else {
                                ForEach(viewModel.currentMonthTransactions) {
                                    transaction in
                                    
                                    NavigationLink {
                                        AddTransactionView(
                                            editingTransaction: transaction
                                        )
                                        .environment(viewModel)
                                    } label: {
                                        TransactionRowView(
                                            color: transaction.category.color,
                                            emoji: transaction.category.emoji,
                                            title: transaction.title,
                                            currency: transaction.currency.rawValue,
                                            date: transaction.date,
                                            amount: transaction.amount
                                        )
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            viewModel.deleteTransaction(transaction)
                                        } label: {
                                            Label("Удалить", systemImage: "trash")
                                        }
                                    }
                                    .listRowBackground(Color.clear)
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 260)
                    }
                    .background(Color(.backgroundMain))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddTransactionView()
                            .environment(viewModel)
                    } label: {
                        Text("Добавить +")
                    }
                }
            }
            .errorAlert(message: $viewModel.errorMessage)
        }
    }
}

#Preview {
    TransactionView()
        .environment(TransactionViewModel())
        .environment(SettingsViewModel())
}
