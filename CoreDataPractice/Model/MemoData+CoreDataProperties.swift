//
//  MemoData+CoreDataProperties.swift
//  CoreDataPractice
//
//  Created by 신동희 on 2023/04/01.
//
//

import Foundation
import CoreData


extension MemoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoData> {
        return NSFetchRequest<MemoData>(entityName: "MemoData")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64

}

extension MemoData : Identifiable {

}
