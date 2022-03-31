//
//  Alarm.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import CoreData

@objc(Alarm)
class Alarm: NSManagedObject {
    
    // MARK: - CoreData Properties
    
    @NSManaged var fireDate: Date
    @NSManaged var isEnabled: Bool
    @NSManaged var title: String
    
    // MARK: - Properties
    
    var id: String { objectID.uriRepresentation().absoluteString }
    
    // MARK: - Init
    
    @discardableResult convenience init(title: String, fireDate: Date, isEnabled: Bool = true, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
//        self.title = title
//        self.fireDate = fireDate
//        self.isEnabled = isEnabled
        set(title: title, fireDate: fireDate, isEnabled: isEnabled)
    }
    
    func set(title: String, fireDate: Date, isEnabled: Bool) {
        self.title = title
        self.fireDate = fireDate
        self.isEnabled = isEnabled
    }
}

extension Alarm {
    static func ==(lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.id == rhs.id
    }
}
