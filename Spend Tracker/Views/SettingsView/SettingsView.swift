//
//  SettingsView.swift
//  Spend Tracker
//
//  Created by SWIFT on 26.03.2026.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(TransactionViewModel.self) var transactionViewModel
       @State private var viewModel = SettingsViewViewModel()
       @State private var showDeleteAlert = false  //
    
    var body: some View {
        
        VStack(spacing: 0) {
         
            ZStack(alignment:.leading) {
                Color.purpleMain
                    .ignoresSafeArea()
                
                Text("Настройки")
                    .foregroundStyle(.white)
                    .font(.system(size: 25, weight: .semibold))
                    .padding()
            }
            .frame(height: 50)
            Spacer()
            ZStack(alignment: .top) {
                Color.backgroundMain
                VStack(spacing: 10){
                    
                    SecondaryTitleView(text: "БЮДЖЕТ")
                    
                    Button {
                        viewModel.openLimitSheet()
                    } label: {
                        SettingsRowView(
                            icon: "dollarsign.circle.fill",
                            iconColor: .yellow,
                            title: "Месячный лимит"
                        ) {
                            HStack(spacing: 6) {
                                Text("₽ \(Int(viewModel.monthlyLimit).formatted())")
                                    .foregroundStyle(.secondary)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    
                    SecondaryTitleView(text: "УВЕДОМЛЕНИЯ")
                    
                    
                    SettingsRowView(
                        icon: "bell.badge",
                        iconColor: .red,
                        title:"Внести траты") {
                            Toggle("", isOn: $viewModel.isReminderEnabled)
                                .labelsHidden()
                                .tint(.lightPurple)
                                .onChange(of: viewModel.isReminderEnabled) {_, newValue in 
                                    viewModel.saveReminder(newValue)
                                }
                        }
                    SecondaryTitleView(text: "ДАННЫЕ")
                    
                    Button {
                      //  TODO
                    } label: { 
                    SettingsRowView(
                        icon: "square.and.arrow.up",
                        iconColor: .lightPurple,
                        title: "Экспорт в CSV",
                        subtitle: "Выгрузить все траты в таблицу"
                    ) {
                        
                    }
                }
                    
                    Button {
                      //  TODO
                    } label: {
                        SettingsRowView(
                            icon: "doc.richtext",
                            iconColor: .lightPurple,
                            title: "Экспорт в PDF",
                            subtitle: "Сохранить отчёт за месяц"
                        ) {
                            
                        }
                    }
                    Button {
                        showDeleteAlert = true
                    } label: {
                        SettingsRowView(
                            icon: "trash.fill",
                            iconColor: .red,
                            title: "Очистить все данные"
                        ) {
                            
                        }
                    }
                    .buttonStyle(.borderless)
                    .foregroundStyle(.red)
                    .alert("Удалить все данные?", isPresented: $showDeleteAlert) {
                        
                                Button("Удалить", role: .destructive) {
                                    viewModel.deleteAllTransactions(transactionViewModel: transactionViewModel)
                                }
                                Button("Отмена", role: .cancel) { }
                            } message: {
                                Text("Все транзакции будут удалены без возможности восстановления")
                            }
                        
                    
                    Text("Все данные хранятся локально на устройстве.")
                        .foregroundStyle(.purpleMain)
                        .opacity(0.7)
                    
                }
                .padding()  
                .padding(.top, 30)
            }
        }
        .sheet(isPresented: $viewModel.showLimitSheet) {
            LimitSheetView(
                initialValue: viewModel.monthlyLimit,
                onSave: { newLimit in 
                    viewModel.applyNewLimit(newLimit)
                },
                onCancel: {
                    viewModel.closeLimitSheet()
                }
            )
            .presentationDetents([.height(260)])
            .presentationDragIndicator(.visible)
        }
    }
    
    
}

#Preview {
    SettingsView()
        .environment(TransactionViewModel())
}
