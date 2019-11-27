//
//  Contato+CoreDataProperties.swift
//  
//
//  Created by JohnnyLutz on 26/11/19.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Contato {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contato> {
        return NSFetchRequest<Contato>(entityName: "Contato")
    }

    @NSManaged public var categoria: String?
    @NSManaged public var nome: String?
    @NSManaged public var telefone: String?

}
