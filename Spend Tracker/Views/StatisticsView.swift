//
//  StatisticsView.swift
//  Spend Tracker
//
//  Created by SWIFT on 24.03.2026.
//

import SwiftUI
import Charts

enum Period: String, CaseIterable {
    case weak = "Неделя"
    case month = "Месяц"
    case year = "Год"
    
}

struct StatisticsView: View {
    @Environment(TransactionViewModel.self) var viewModel
    
    @State private var selectablePeriod = Period.month
    
    init() { pickerConfig() }
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            ZStack(alignment: .topLeading) {
                Color(.purpleMain)
                    .frame(height: 180)
                    .ignoresSafeArea()
                
                VStack() {
                    HStack {
                        Text("Статистикa")
                            .foregroundStyle(.white)
                            .font(.system(size: 25, weight: .semibold))
                        
                        Spacer()
                        
                    }
                    Picker("Период", selection: $selectablePeriod){
                        ForEach(Period.allCases, id: \.self) { period in 
                            Text(period.rawValue)
                            
                        }
                        
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)
            }
            
            
            VStack {
                
                HStack(spacing:20) {
                    
                    RoundChartView(
                        data: viewModel.expensesByCategory(for: selectablePeriod),
                        totalExpenses: viewModel.totalExpenses(for: selectablePeriod)
                    )
                    .frame(width: 150,height: 150)
                    
                    VStack {
                        ForEach(
                            viewModel.expensesByCategory(for: selectablePeriod), id:\.category)  { item in
                            CategoryGraphicRow(
                                color:item.category.color ,
                                title: item.category.title,
                                percent: item.percent
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, -50)
            }
            
            HStack {
                Text("Траты по дням").bold()
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            
            Chart(
                viewModel.expensesByDay(for: selectablePeriod), id: \.weekDay)  { day in
                BarMark(
                    x: .value("День", day.weekDay),
                    y: .value("Сумма", day.total)
                )
                .foregroundStyle(day.total < 2000 ? .lightPurple : .purpleMain)
                .cornerRadius(8)
            }
            
            .frame( height: 100)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)  
                    .stroke(.gray.opacity(0.3), lineWidth: 1)
            )
            
            .padding(.horizontal)
            
            SecondaryText(text: "История")
            
            ScrollView {
                ForEach(
                    viewModel.transactionsByPeriod(selectablePeriod)
                ) { transaction in
                TransactionRowView(
                    color: transaction.category.color,
                    emoji: transaction.category.emoji,
                    title: transaction.title,
                    currency: transaction.currency.rawValue,
                    date: transaction.date,
                    amount: transaction.amount
                )
                    Divider()
                    
            }
        }
            .padding()
            .background(Color(.backgroundMain))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        }
       
    }
    
}

private extension StatisticsView {
    
    func pickerConfig() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor(Color.purpleMain)], for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white], for: .normal
        )
        UISegmentedControl.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    
}

#Preview {
    StatisticsView()
        .environment(TransactionViewModel())
}
