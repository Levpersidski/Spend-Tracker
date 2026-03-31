//
//  LimitSheetViewViewModel.swift
//  Spend Tracker
//
//  Created by SWIFT on 29.03.2026.
//

import Foundation
import Observation

@Observable final class LimitSheetViewModel {
    
    var limitText: String = ""
    var showAlert: Bool = false
    var alertMessage: String = ""
    
    private var lastValidValue: Int = 0
    
    var isSaveDisabled: Bool {
        limitText.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func setup(initialValue: Int) {
           lastValidValue = initialValue
           limitText = String(initialValue)
       }
    
    func validated() -> Int? {
        guard let value = Int(limitText.trimmingCharacters(in: .whitespaces)), value > 0 else {
                alertMessage = "Введите корректное целое число"
                showAlert = true
            limitText = String(lastValidValue)  // ← восстанавливаем поле
                return nil
            }
        lastValidValue = value
            return value
        }
    }
