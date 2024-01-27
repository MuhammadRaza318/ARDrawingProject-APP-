//
//  TryProViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 01/01/2024.
//

import UIKit

class TryProViewController: UIViewController {

    @IBOutlet weak var TryBackButton: UIButton!
    
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var StartNowButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.StartNowButton.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        CancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        TryBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func cancelButtonPressed() {
       }

       @objc func backButtonPressed() {
           print(self.navigationController?.viewControllers)
           self.navigationController?.popViewController(animated: true)
           dismiss(animated: true, completion: nil)
           }
            
       }






//           for viewController in navigationController?.viewControllers ?? [] {
//                   if let dashBoardViewController = viewController as? DashBoardViewController {
//                       navigationController?.popToViewController(dashBoardViewController, animated: true)
//                       return
//                   }
//               }
//               dismiss(animated: true, completion: nil)
