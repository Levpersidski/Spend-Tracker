//
//  SecondaryText.swift
//  Spend Tracker
//
//  Created by SWIFT on 23.03.2026.
//

import SwiftUI

struct SecondaryText: View {
    
    let text: String
    
    var body: some View {
        
        Text(text)
            .font(.system(size: 13))
            .foregroundStyle(.secondary)
            .padding(.bottom, 10)
    }
}

#Preview {
    SecondaryText(text: "текст")
}
