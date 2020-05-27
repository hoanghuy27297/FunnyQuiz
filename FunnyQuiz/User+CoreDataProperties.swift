//
//  User+CoreDataProperties.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 27/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var totalPoints: Int16
    @NSManaged public var attempt: NSSet?

}

// MARK: Generated accessors for attempt
extension User {

    @objc(addAttemptObject:)
    @NSManaged public func addToAttempt(_ value: Attempts)

    @objc(removeAttemptObject:)
    @NSManaged public func removeFromAttempt(_ value: Attempts)

    @objc(addAttempt:)
    @NSManaged public func addToAttempt(_ values: NSSet)

    @objc(removeAttempt:)
    @NSManaged public func removeFromAttempt(_ values: NSSet)

}
