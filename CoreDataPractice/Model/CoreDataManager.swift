//
//  CoreDataManager.swift
//  CoreDataPractice
//
//  Created by 신동희 on 2023/04/01.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    typealias CompletionHandler = () -> Void
    
    // MARK: - Propertys
    
    static let shared = CoreDataManager()
    private init() {}
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    private let modelName = "MemoData"
    
    
    
    // MARK: - Methods
    
    func saveMemoData(text: String, color: ColorType, completion: CompletionHandler) {
        defer { completion() }
        
        guard let context,
              let entity = NSEntityDescription.entity(forEntityName: modelName, in: context),
              let memoData = NSManagedObject(entity: entity, insertInto: context) as? MemoData
        else { return }
        
        memoData.memoText = text
        memoData.date = Date()
        memoData.color = color.rawValue
        
        if context.hasChanges {
            saveContext(context: context)
        }
    }
    
    
    func deleteMemoData(data: MemoData, completion: CompletionHandler) {
        defer { completion() }
        
        guard let date = data.date,
              let context
        else { return }
        
        let request = fetchRequest(date: date)
        
        do {
            guard let fetchedMemoList = try fetchMemoList(context: context, request: request),
                  let targetMemo = fetchedMemoList.first
            else { return }
            
            
            context.delete(targetMemo)
            
            if context.hasChanges {
                saveContext(context: context)
            }
        }
        catch {
            print(error)
        }
    }
    
    
    func updateMemoData(newMemoData: MemoData, completion: CompletionHandler) {
        defer { completion() }
        
        guard let date = newMemoData.date,
              let context = context
        else { return }
        
        let request = fetchRequest(date: date)
        
        do {
            if let fetchedMemoList = try fetchMemoList(context: context, request: request) {
                if var targetMemo = fetchedMemoList.first {
                    targetMemo = newMemoData
                    
                    if context.hasChanges {
                        saveContext(context: context)
                    }
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    
    private func fetchRequest(date: Date) -> NSFetchRequest<NSManagedObject> {
        let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
        request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
        return request
    }
    
    
    private func saveContext(context: NSManagedObjectContext) {
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    
    private func fetchMemoList(context: NSManagedObjectContext, request: NSFetchRequest<NSManagedObject>) throws -> [MemoData]? {
        return try context.fetch(request) as? [MemoData]
    }
}
