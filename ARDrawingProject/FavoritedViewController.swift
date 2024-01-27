//
//  FavoritedViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 15/01/2024.
//

import UIKit
import CoreData
class FavoritedViewController: UIViewController {
    @IBOutlet weak var favoritcollectionView: UICollectionView!
    @IBOutlet weak var FavoritedBackButton: UIButton!
    var favoritedImages : [ARDrawing] = []
    //file . add array
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoritedBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.navigationController?.isNavigationBarHidden = true
        displayFavoritedImages()
            }
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    func displayFavoritedImages() {
            favoritedImages = CoreDataHelper.shared.fetchFavoriteImages()
            favoritcollectionView.reloadData()
        }
}
extension FavoritedViewController: UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        //                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritCollectionViewCell", for: indexPath) as! FavoritCollectionViewCell
        //
        //        let imageData = favoritedImages[indexPath.row]
        //
        //              if let imageDataString = String(data: imageData.images ?? Data(), encoding: .utf8),
        //                 let image = UIImage(named: imageDataString) {
        //                  cell.FavImage.image = image
        //              }
        //        cell.heartBtnRemove.tag = indexPath.row
        //        cell.heartBtnRemove.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
        //
        //                    return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritCollectionViewCell", for: indexPath) as! FavoritCollectionViewCell
        
        let imageData = favoritedImages[indexPath.row]
        
        if let imageDataString = String(data: imageData.images ?? Data(), encoding: .utf8),
           let image = UIImage(named: imageDataString) {
            cell.FavImage.image = image
        }
        
        cell.heartBtnRemove.tag = indexPath.row
        cell.heartBtnRemove.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 20) / 2
        let height = width * 1 //ratio
        return CGSize(width: 110, height: 170)
        
    }
    @objc func removeButtonTapped(_ sender: UIButton) {
        let indexToRemove = sender.tag
        let imageData = favoritedImages[indexToRemove]
        CoreDataHelper.shared.removeFavoriteImage(imageData: imageData)

        favoritedImages.remove(at: indexToRemove)
        favoritcollectionView.deleteItems(at: [IndexPath(item: indexToRemove, section: 0)])
    }
}
