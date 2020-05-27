//
//  Attempts+CoreDataProperties.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 27/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//
//

import Foundation
import CoreData


extension Attempts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attempts> {
        return NSFetchRequest<Attempts>(entityName: "Attempts")
    }

    @NSManaged public var area: String?
    @NSManaged public var date: String?
    @NSManaged public var points: Int16
    @NSManaged public var ofUser: User?

}
