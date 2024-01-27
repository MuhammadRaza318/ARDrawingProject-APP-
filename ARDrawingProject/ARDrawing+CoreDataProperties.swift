//
//  ARDrawing+CoreDataProperties.swift
//  ARDrawingProject
//
//  Created by Raza on 24/01/2024.
//
//

import Foundation
import CoreData


extension ARDrawing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ARDrawing> {
        return NSFetchRequest<ARDrawing>(entityName: "ARDrawing")
    }

    @NSManaged public var images: Data?

}

extension ARDrawing : Identifiable {

}
