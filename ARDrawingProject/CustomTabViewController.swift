//
//  CustomTabViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 22/01/2024.
//

import UIKit

class CustomTabViewController: UITabBarController ,  UITabBarControllerDelegate {
    
    @IBOutlet weak var TabBarItems: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        if let items = tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode(.alwaysOriginal)
                }
                if let selectedImage = item.selectedImage {
                    item.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    }
    
    override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()
                let tabBarWidth = tabBar.frame.size.width
                let tabBarHeight = tabBar.frame.size.height
                let screenWidth = view.frame.size.width
                let screenHeight = view.frame.size.height
        let xCoordinate = (screenWidth - tabBarWidth) / 4
        let yCoordinate = (screenHeight - tabBarHeight) / 4
        
                tabBar.frame = CGRect(x: xCoordinate, y: yCoordinate, width: tabBarWidth, height: tabBarHeight)
            }
    }
    

   
