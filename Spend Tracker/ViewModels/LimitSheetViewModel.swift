//
//  LimitSheetViewModel.swift
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
    
    var canSave: Bool {
        !limitText.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var parsedValue: Int {
        lastValidValue
    }

    
    func setup(initialValue: Int) {
           lastValidValue = initialValue
           limitText = String(initialValue)
       }
    
    func validate() -> Bool {
        guard let value = Int(limitText.trimmingCharacters(in: .whitespaces)), value > 0 else {
                alertMessage = "Введите корректное целое число"
                showAlert = true
            limitText = String(lastValidValue)  // ← восстанавливаем поле
            return false
            }
        lastValidValue = value
        return true
        }
    }
