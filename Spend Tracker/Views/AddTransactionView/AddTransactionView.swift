//
//  NewTransactionView.swift
//  Spend Tracker
//
//  Created by SWIFT on 22.03.2026.
//

import SwiftUI

enum Field {
    case name
    case amount
}

struct AddTransactionView: View {
    
    @Environment(TransactionViewModel.self) var transactionVM
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: AddTransactionViewModel
    @FocusState private var focusedField: Field?
    @State private var animateSuccess = false

    var selectedTab: Binding<Int>? = nil
    
    
    
    init(editingTransaction: Transaction? = nil, selectedTab: Binding<Int>? = nil) {
        _viewModel = State(initialValue: AddTransactionViewModel(editingTransaction: editingTransaction))
        self.selectedTab = selectedTab
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                SecondaryText(text: "Название")
                
                CustomTextField(
                    placeholder: "Вкусвилл",
                    text: $viewModel.transactionName
                )
                .focused($focusedField, equals: .name)
                
                SecondaryText(text: "Сумма")
                    .padding(.top)
                
                HStack {
                    Menu {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Button(currency.title) {
                                viewModel.selectedCurrency = currency
                            }
                        }
                    } label: {
                        Text(viewModel.selectedCurrency.rawValue)
                            .frame(width: 35, height: 40)
                            .font(.system(.headline, weight: .bold))
                            .background(Color.purpleMain)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    CustomTextField(placeholder: "Сумма", text: $viewModel.amount)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .amount)
                }
                
                SecondaryText(text: "Категория")
                    .padding(.top)
                
                LazyVGrid(
                    columns: [GridItem(), GridItem(), GridItem()],
                    spacing: 12
                ) {
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
                            viewModel.selectedCategory == category
                            ? Color.purpleMain
                            : Color(.systemGray6)
                        )
                        .foregroundStyle(
                            viewModel.selectedCategory == category
                            ? .white
                            : category.color
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            // ДОБАВИЛ: при выборе категории убираем клавиатуру
                            focusedField = nil
                            viewModel.selectedCategory = category
                        }
                    }
                }
                
                SecondaryText(text: "Дата")
                    .padding(.top)
                
                CustomDatePicker(date: $viewModel.date)
                    .onTapGesture {
                        focusedField = nil
                    }
                
                Button {
                    focusedField = nil
                    viewModel.save(transactionViewModel: transactionVM)
                } label: {
                    Text("Сохранить")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.purpleMain)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(!viewModel.isFormValid)
                .padding(.top)
                
                Spacer(minLength: 40)
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .onTapGesture {
            focusedField = nil
        }
        .toolbarBackground(Color(.purpleMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            viewModel.resetIfNeeded()
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Готово") {
                    focusedField = nil
                }
            }
        }
        .overlay {
                if viewModel.showSuccess {
                    successOverlay
                        .onAppear {
                            withAnimation(.spring()) {
                                animateSuccess = true
                            }
                            // через 1.5 секунды закрываем
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                navigateBack()
                            }
                        }
                }
            }
        
    }
    
    
    private var successOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.green)
                
                Text(
                    viewModel.isEditing ? "Трата добавлена!" : "Трата обновлена!"
                )
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground).opacity(0.8))
            )
            .scaleEffect(animateSuccess ? 1.0 : 0.5)
            .opacity(animateSuccess ? 1.0 : 0)
            .animation(.spring(), value: animateSuccess)
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
    NavigationStack {
        AddTransactionView()
            .environment(TransactionViewModel())
    }
}
