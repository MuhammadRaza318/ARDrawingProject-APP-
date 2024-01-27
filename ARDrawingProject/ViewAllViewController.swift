//
//  ViewAllViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 02/01/2024.
//

import UIKit

class ViewAllViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    var images: [UIImage?] = []
    @IBOutlet weak var BackViewAllButton: UIButton!
   
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var ButtonAll: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        collectionview.dataSource = self
        collectionview.delegate = self
        
        
        
        ButtonAll.layer.borderWidth = 1
     ButtonAll.layer.borderColor = UIColor.blue.cgColor
        
        BackViewAllButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    @objc func backButtonPressed() {
            // Back Button
            self.navigationController?.popViewController(animated: true)
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return images.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewAllCollectionViewCell", for: indexPath) as? ViewAllCollectionViewCell else {
               fatalError("Unable to dequeue ImageCollectionViewCell")
           }
           
           // Configure the cell
//           cell.imageView.image = images[indexPath.item]
           cell.ViewAllImage.image = images[indexPath.item]
           return cell
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (collectionView.frame.size.width - 20) / 2
//        return CGSize(width: 110, height: 170)
        let width = (self.view.frame.size.width - 20) / 3
          return CGSize(width: 130, height: 170)
    }

}
