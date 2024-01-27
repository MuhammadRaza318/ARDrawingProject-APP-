//
//  ImageModels.swift
//  ARDrawingProject
//
//  Created by Raza on 28/12/2023.
//

import Foundation
var favoritedImages: [String] = []
struct ImageModels {
    var  allImages : [AllImage]
    init(allImages: [AllImage]) {
            self.allImages = allImages
        }
}
struct  AllImage {
    var imageName : String
    var isPro : Bool
   
}




