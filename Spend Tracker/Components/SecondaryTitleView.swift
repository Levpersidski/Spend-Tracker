//
//  SecondaryTitleView.swift
//  Spend Tracker
//
//  Created by SWIFT on 29.03.2026.
//

import SwiftUI

struct SecondaryTitleView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.gray.opacity(0.7))
            
            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    SecondaryTitleView(text: "Заголовок")
}
