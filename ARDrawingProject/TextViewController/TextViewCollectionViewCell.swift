//
//  TextViewCollectionViewCell.swift
//  ARDrawingProject
//
//  Created by Raza on 01/01/2024.
//

import UIKit

class TextViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textIcon: UIButton!
    @IBOutlet weak var TextLabel: UILabel!
    func setup(with textlabele: Textlabele, isIconHidden: Bool) {
            TextLabel.text = textlabele.label
            textIcon.isHidden = isIconHidden
            isUserInteractionEnabled = true
        }
}
