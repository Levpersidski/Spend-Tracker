//
//  CustomTextField.swift
//  Spend Tracker
//
//  Created by SWIFT on 22.03.2026.
//

import SwiftUI

struct CustomTextField: View {
    
    let placeholder : String
    
    @Binding var text: String
    
    var body: some View {
        
        TextField(placeholder, text: $text )
            .padding()
            .frame(height: 40)
            .background(Color.purpleMain.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    CustomTextField(placeholder: "Вкусвилл", text: .constant(""))
}
