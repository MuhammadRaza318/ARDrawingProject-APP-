//
//  UserDefaultData.swift
//  ARDrawingProject
//
//  Created by Raza on 16/01/2024.
//

import Foundation
import UIKit
import CoreData


class CoreDataHelper {
    static let shared = CoreDataHelper()

       fileprivate lazy var persistentContainer: NSPersistentContainer = {
           let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
           return container
       }()

       private init() {}
    func saveFavoriteImage(imageData: AllImage) {
          let context = persistentContainer.viewContext

          let favoriteImage = ARDrawing(context: context)
        favoriteImage.images = imageData.imageName.data(using: .utf8)

          do {
              try context.save()
          } catch {
              print("Error saving favorited image: \(error.localizedDescription)")
          }
      }
// string type array
    // decode return ardraimg return  string 
      func fetchFavoriteImages() -> [ARDrawing] {
          let context = persistentContainer.viewContext

          do {
              let fetchRequest: NSFetchRequest<ARDrawing> = ARDrawing.fetchRequest()
              return try context.fetch(fetchRequest)
          } catch {
              print("Error fetching favorited images: \(error.localizedDescription)")
              return []
          }
      }
    func removeFavoriteImage(imageData: ARDrawing) {
           let context = persistentContainer.viewContext

           do {
               context.delete(imageData)
               try context.save()
           } catch {
               print("Error removing favorited image: \(error.localizedDescription)")
           }
       }
   }


