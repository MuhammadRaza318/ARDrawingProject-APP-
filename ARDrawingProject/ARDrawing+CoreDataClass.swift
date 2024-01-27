//
//  ARDrawing+CoreDataClass.swift
//  ARDrawingProject
//
//  Created by Raza on 24/01/2024.
//
//

import Foundation
import CoreData

@objc(ARDrawing)
public class ARDrawing: NSManagedObject {
    @NSManaged public var imageName: String?
    @NSManaged public var isPro: Bool
}
