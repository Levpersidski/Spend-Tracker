//
//  Error.swift
//  Spend Tracker
//
//  Created by SWIFT on 02.04.2026.
//

import Foundation

enum AppError: LocalizedError {
    case fetchFailed
    case saveFailed
    case deleteFailed
    case exportFailed
    case unknown(Error)
    
    // Это свойство показывается пользователю в alert
    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            "Не удалось загрузить транзакции"
        case .saveFailed:
            "Не удалось сохранить. Проверьте свободное место на устройстве"
        case .deleteFailed:
            "Не удалось удалить транзакцию"
        case .exportFailed:
            "Не удалось создать файл экспорта"
        case .unknown(let error):
            "Произошла ошибка: \(error.localizedDescription)"
        }
    }
}
