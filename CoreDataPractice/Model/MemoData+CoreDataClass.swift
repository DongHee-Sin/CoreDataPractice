//
//  MemoData+CoreDataClass.swift
//  CoreDataPractice
//
//  Created by 신동희 on 2023/04/01.
//
//

import Foundation
import CoreData

@objc(MemoData)
public final class MemoData: NSManagedObject {

    let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
