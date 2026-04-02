//
//  ShareSheet.swift
//  Spend Tracker
//
//  Created by SWIFT on 02.04.2026.
//


import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
}
