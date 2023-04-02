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
    

    
    // MARK: - Create
    
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
            do {
                try context.save()
            }
            catch {
                print(error)
            }
        }
    }
    
    
    
    // MARK: - Delete
    
    func deleteMemoData(data: MemoData, completion: CompletionHandler) {
        defer { completion() }
        
        guard let date = data.date,
              let context
        else { return }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
        request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
        
        do {
            guard let fetchedMemoList = try context.fetch(request) as? [MemoData],
                  let targetMemo = fetchedMemoList.first
            else { return }
            
            
            context.delete(targetMemo)
            
            if context.hasChanges {
                do {
                    try context.save()
                }
                catch {
                    print(error)
                }
            }
        }
        catch {
            print(error)
        }
    }
}
