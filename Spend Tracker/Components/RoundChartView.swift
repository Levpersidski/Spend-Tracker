//
//  RoundChart.swift
//  Spend Tracker
//
//  Created by SWIFT on 26.03.2026.
//

import SwiftUI
import Charts

struct RoundChartView: View {
    
    let data: [(category: Category, total: Double, percent: Double)]
    let totalExpenses: Double
    
    var body: some View {
        
       
        ZStack {
            Chart(data, id: \.category) { item in
                    SectorMark(
                        angle: .value("Amount", item.total),
                        innerRadius: .ratio(0.65),
                        angularInset: 1
                    )
                    .foregroundStyle(item.category.color)
                    .cornerRadius(5)
                }
                
            
            
            Text("\(totalExpenses / 1000, specifier: "%.1f")k\nвсего")
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    RoundChartView(
        data: [(category: Category.coffee, total: 345, percent: 32),
               (category: Category.fun, total: 546, percent: 32),
               (category: Category.food, total: 345, percent: 32)
              ],
        totalExpenses: 3234
    )
}
