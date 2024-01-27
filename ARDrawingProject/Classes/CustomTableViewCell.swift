//
//  CustomTableViewCell.swift
//  ARDrawingProject
//
//  Created by Raza on 25/12/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var ImageView3: UIImageView!
    
    @IBOutlet weak var ImageView2: UIImageView!
    @IBOutlet weak var ImageView1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
