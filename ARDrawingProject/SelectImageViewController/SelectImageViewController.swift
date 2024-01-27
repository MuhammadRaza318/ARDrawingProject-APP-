//
//  SelectImageViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 27/12/2023.
//

import UIKit

class SelectImageViewController: UIViewController {

    @IBOutlet weak var SelectimageBackButton: UIButton!
    @IBOutlet weak var SelectImageView: UICollectionView!
    var selectedImageNames: [String] = [] 
    var selectimages: [String] = ["people","food","Kids", "food","car","nature","animal","people","Anime","people","Kids","people","people","food","architec"]
   
    @IBOutlet weak var ButtonAll: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        
        SelectImageView.collectionViewLayout = UICollectionViewFlowLayout()
        SelectimageBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        ButtonAll.layer.borderWidth = 1
        ButtonAll.layer.borderColor = UIColor.blue.cgColor
    }
    
    @objc func backButtonPressed() {
            self.navigationController?.popViewController(animated: true)
        }
}

extension SelectImageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCollectionViewCell", for: indexPath) as! SelectCollectionViewCell
        cells.ImagePick.image = UIImage(named: selectimages[indexPath .row])
        return cells
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 2
        return CGSize(width: 100, height: 130)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "ContinueViewController") as! ContinueViewController
//        desVC.ImageReceived = UIImage(named:selectimages[indexPath.row] )!
        self.navigationController?.pushViewController(desVC, animated: true)
    }
}

