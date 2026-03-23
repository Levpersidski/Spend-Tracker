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
        NavigationStack {
            ZStack(alignment: .top) {
                
                // Фиолетовый фон сверху
                Color(.purpleMain)
                    .frame(height: 300)
                    .ignoresSafeArea()
                
                
                    VStack(spacing: 0) {
                        
                        // Фиолетовая карточка
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Привет,Роман 👋")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                         
                            
                            SpendingView()
                        }
                        .padding()
                        .padding(.bottom, 30)
                        
                        // Белый блок с закруглёнными углами сверху
                        VStack(alignment: .leading, spacing: 16) {
                            
                            // Категории
                            CategoryView()
                                .padding(.horizontal)
                            // Транзакции
                            Text("Последние операции")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.horizontal)
                            ScrollView {
                                ForEach(
                                    viewModel.sortedTransactions
                                ) { transaction in
                                TransactionRowView(
                                    color: transaction.category.color,
                                    emoji: transaction.category.emoji,
                                    title: transaction.title,
                                    currency: transaction.currency,
                                    date: transaction.date,
                                    amount: transaction.amount
                                )
                            }
                        }
                            .padding(.top, 5)
                            .background(Color(.backgroundMain))
                        .clipShape(RoundedRectangle(cornerRadius: 24))  // ← скругление сверху
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                NavigationLink {
                                    AddTransactionView()
                                } label: {
                                    Text("Добавить +")
                                } 
                            }
                        }
                    }
                }
            }
          
        }
    }
}

#Preview {
    TransactionView()
        .environment(TransactionViewModel())
}


