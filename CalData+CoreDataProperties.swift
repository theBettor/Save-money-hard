//
//  CalData+CoreDataProperties.swift
//  
//
//  Created by 김찬교 on 2023/09/28.
//
//

import Foundation
import CoreData


extension CalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalData> {
        return NSFetchRequest<CalData>(entityName: "CalData")
    }

    @NSManaged public var callabel: String?
    @NSManaged public var caltext: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64
    
    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.date else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}

extension CalData : Identifiable {

}

