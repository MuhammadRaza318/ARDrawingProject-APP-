//
//  VIEWViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 03/01/2024.
//

import UIKit

class VIEWViewController: UIViewController {

    @IBOutlet weak var ComingSoon: UILabel!
    @IBOutlet weak var ViewBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.ComingSoon.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        self.navigationController?.isNavigationBarHidden = true
        ViewBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
      
    }
    @objc func centerButtonTapped() {
            // Handle the center button tap
            print("Center button tapped")
        }
    @objc func backButtonPressed() {
            // Back Button
            self.navigationController?.popViewController(animated: true)
        }
}
