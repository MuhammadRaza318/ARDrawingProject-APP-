//
//  ViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 15/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ButtonLetStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        self.ButtonLetStart.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        
    }

    
    @IBAction func LicienceButton(_ sender: Any) {
        if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               }
    }
    
    @IBAction func PrivacyButton(_ sender: Any) {
        if let url = URL(string: "https://docs.google.com/document/u/0/d/19oVhRE0EFgVbKkF74oP-joakzUrUANAm6lq9cUuNMXM/mobilebasic") {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               }
    }
}
