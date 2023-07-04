//
//  Entry+CoreDataProperties.swift
//  Journal
//
//  Created by Owais Quadri on 2023-07-03.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}

extension Entry : Identifiable {
  // you can edit this part

    func getMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        if let date = date {
            return formatter.string(from: date).uppercased()
        }
        return "ERR"
    }
    func getDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        if let date = date {
            return formatter.string(from: date).uppercased()
        }
        return "32"
    }
}
