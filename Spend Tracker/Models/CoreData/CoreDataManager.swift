//
//  CoreDataManager.swift
//  Spend Tracker
//
//  Created by SWIFT on 30.03.2026.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SpendTracker")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data не загрузился: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения: \(error)")
        }
    }
}


/*
 static let shared — singleton, один экземпляр на всё приложение. Используем везде через CoreDataManager.shared.
 
 NSPersistentContainer — главный объект Core Data. Соединяет .xcdatamodeld схему с реальным файлом БД на диске устройства. "SpendTracker" — имя твоего .xcdatamodeld файла.
 context — это "рабочий стол" для операций с БД. Через него читаем, пишем, удаляем объекты. Изменения в context живут в памяти пока не вызовешь save().
 save() — только тогда данные физически записываются на диск.

 */
