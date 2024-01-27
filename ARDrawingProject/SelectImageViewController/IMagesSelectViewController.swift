//
//  IMagesSelectViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 22/12/2023.
//

import UIKit

class IMagesSelectViewController: UIViewController {
    
    @IBOutlet weak var ImageButton: UIButton!
    
    @IBOutlet weak var BackImageSelectView: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var images: [String] = ["people","food","Kids", "food","car","nature","animal","Anime","architec","object"]
    
    var ImageNames: [String] = ["People" , "Food" , "Kids", "car","Nature","Animal","Anime","Architec","Object"]

    
    @IBOutlet weak var ButtonTExt: UIButton!
    @IBOutlet weak var ButtonOBject: UIButton!
    @IBOutlet weak var IMAGESelectUIView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Set the collectionViewLayout
            collectionView.collectionViewLayout = UICollectionViewFlowLayout()

        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        
        BackImageSelectView.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)

//        IMAGESelectUIView.roundCornerView(corners: [.bottomLeft , .bottomRight], raduis: 30)
//        self.view.addSubview(IMAGESelectUIView)
        
        self.ButtonOBject.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        
        ButtonTExt.layer.borderWidth = 1
        ButtonTExt.layer.borderColor = UIColor.blue.cgColor
    }
    
    @objc func backButtonPressed() {
            // Use this method to navigate back to the previous view controller
            self.navigationController?.popViewController(animated: true)
        }
}
extension IMagesSelectViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.LabelImageselect.text = ImageNames[indexPath.row]
        cell.Imageselect.image = UIImage(named: images[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 2
        return CGSize(width: 110, height: 170)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageName = images[indexPath.row]
        let nextViewController = SelectImageViewController()
        nextViewController.selectedImageNames = [selectedImageName]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }


   }


        
        
    

