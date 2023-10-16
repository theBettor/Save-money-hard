//
//  CalData+CoreDataProperties.swift
//  
//
//  Created by 김찬교 on 2023/09/15.
//
//

import Foundation
import CoreData


extension CalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalData> {
        return NSFetchRequest<CalData>(entityName: "CalData")
    }

    @NSManaged public var callabel: String? // 저장 속성처럼 보이긴하나 계산 속성.
    @NSManaged public var caltext: String?
    @NSManaged public var date: Date?

}
