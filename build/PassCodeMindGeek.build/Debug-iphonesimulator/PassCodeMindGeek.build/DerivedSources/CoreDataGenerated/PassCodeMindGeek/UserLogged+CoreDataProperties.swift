//
//  UserLogged+CoreDataProperties.swift
//  
//
//  Created by Rafael Cunha de Oliveira on 2020-04-23.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension UserLogged {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserLogged> {
        return NSFetchRequest<UserLogged>(entityName: "UserLogged")
    }

    @NSManaged public var blocked: Date?
    @NSManaged public var code: String?
    @NSManaged public var isLogged: Bool

}
