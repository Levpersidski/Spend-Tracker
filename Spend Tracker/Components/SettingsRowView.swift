//
//  SettingsRowView.swift
//  Spend Tracker
//
//  Created by SWIFT on 27.03.2026.
//

import SwiftUI

struct SettingsRowView<TrailingContent: View>: View {
    let icon: String
    let iconColor: Color
    let title: String
    var subtitle: String? = nil 
    @ViewBuilder let trailingContent: () -> TrailingContent 


    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemGray6))
                    .frame(width: 52, height: 52)

                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundStyle(iconColor)
            }

            VStack(alignment: .leading, spacing: 3) {
                            Text(title)
                                .font(.system(size: 20, weight: .medium))
                                .opacity(0.7)
                                .foregroundStyle(.primary)

                            if let subtitle {
                                Text(subtitle)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)
                            }
                        }

            Spacer()

            trailingContent()
        }
        .padding(.horizontal, 16)
        .frame(height: 76)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    SettingsRowView(
        icon: "dollarsign.circle.fill",
        iconColor: .yellow,
        title: "Внести траты"
    ) {
        HStack(spacing: 6) {
            Text("₽ 40 000")
                .foregroundStyle(.secondary)

            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
