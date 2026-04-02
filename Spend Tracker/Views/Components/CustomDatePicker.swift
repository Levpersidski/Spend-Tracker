//
//  CustomDatePicker.swift
//  Spend Tracker
//
//  Created by SWIFT on 23.03.2026.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var date: Date
    @State private var showDatePicker = false
    
    var body: some View {
        Text(date.formatted(date: .long, time: .omitted))
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 40)
            .padding(.horizontal)
            .background(Color.purpleMain.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture { showDatePicker = true }
            .sheet(isPresented: $showDatePicker) {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(.purpleMain)
                    .presentationDetents([.medium])
            }
    }
}

#Preview {
    CustomDatePicker(date: .constant(Date.now))
}
