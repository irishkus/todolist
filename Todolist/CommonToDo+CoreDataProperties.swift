//
//  CommonToDo+CoreDataProperties.swift
//  Todolist
//
//  Created by Ирина Соловьева on 05/04/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//
//

import Foundation
import CoreData


extension CommonToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CommonToDo> {
        return NSFetchRequest<CommonToDo>(entityName: "CommonToDo")
    }

    @NSManaged public var toDo: String?
    @NSManaged public var important: Int16

}
