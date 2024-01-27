//
//  ImageViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 28/12/2023.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var TabBarView: UIView!
    @IBOutlet weak var ViewText: UIView!
    @IBOutlet weak var ProfileButton: UIButton!
    
    @IBOutlet weak var FavourtieButton: UIButton!
    @IBOutlet weak var ButtonText: UIButton!
    @IBOutlet weak var ButtonObject: UIButton!
    @IBOutlet weak var BackButtonImageViewController: UIButton!
    @IBOutlet weak var myCollectionView:
    UICollectionView!
    
    private let spacing:CGFloat = 2
    var isButtonObjectClicked = false
    
    var imageList = [ImageData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideSpace()
      //  TabBarView.translatesAutoresizingMaskIntoConstraints = true
        updateGradientColor()
        
        FavourtieButton.addTarget(self, action: #selector(FButtonPressed), for: .touchUpInside)
        BackButtonImageViewController.addTarget(self, action: #selector(BackButtonPressed), for: .touchUpInside)
        
        self.navigationController?.isNavigationBarHidden = true
       // self.ButtonObject.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
    //    ButtonObject.addTarget(self, action: #selector(ObjectButtonPressed), for: .touchUpInside)
     //   ButtonText.addTarget(self, action: #selector(TextButtonPressed), for: .touchUpInside)
        
     //   ButtonText.layer.borderWidth = 1
     //   ButtonText.layer.borderColor = UIColor.blue.cgColor
        
        fillData()
      
        
    }
    @objc func BackButtonPressed() {
        for viewController in navigationController?.viewControllers ?? [] {
            if let DashBoardViewController = viewController as? DashBoardViewController {
                navigationController?.popToViewController(DashBoardViewController, animated: true)
                return
            }
        }
    }
    @objc func FButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "FavoritedViewController") as? FavoritedViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func fillData()
    {
        var allImagesArray: [AllImage] = []
        allImagesArray = [AllImage(imageName: "people1" , isPro: false) , AllImage(imageName: "people2" , isPro: true), AllImage(imageName: "people3" , isPro: false), AllImage(imageName: "people4" , isPro: true) , AllImage(imageName: "people5" , isPro: false) , AllImage(imageName: "people6" , isPro: true) , AllImage(imageName: "people7" , isPro: false), AllImage(imageName: "people8" , isPro: true), AllImage(imageName: "people9" , isPro: false), AllImage(imageName: "people10" , isPro: false), AllImage(imageName: "people11" , isPro: true), AllImage(imageName: "people12" , isPro: true), AllImage(imageName: "people13" , isPro: true),AllImage(imageName: "people14" , isPro: true), AllImage(imageName: "people15" , isPro: true), AllImage(imageName: "people16" , isPro: false), AllImage(imageName: "people17" , isPro: true),AllImage(imageName: "people18" , isPro: false), AllImage(imageName: "people19" , isPro: false), AllImage(imageName: "people20" , isPro: false),AllImage(imageName: "people21" , isPro: false),AllImage(imageName: "people91" , isPro: true)]
            let image1 = ImageData(ImageC: "People", imageModels: allImagesArray)
            imageList.append(image1)
        
        allImagesArray = [AllImage(imageName: "k1", isPro: true) ,AllImage(imageName: "k2", isPro: false) ,AllImage(imageName: "k3", isPro: true) ,AllImage(imageName: "k4", isPro: false) ,AllImage(imageName: "k5", isPro: false) ,AllImage(imageName: "k6", isPro: false) ,AllImage(imageName: "k7", isPro: false),AllImage(imageName: "k8", isPro: true) ,AllImage(imageName: "k9", isPro: false),AllImage(imageName: "k10", isPro: true),AllImage(imageName: "k11", isPro: false),AllImage(imageName: "k12", isPro: true),AllImage(imageName: "k13", isPro: false),AllImage(imageName: "k14", isPro: false),AllImage(imageName: "k15", isPro: false),AllImage(imageName: "k16", isPro: true),AllImage(imageName: "k17", isPro: false),AllImage(imageName: "k18", isPro: true),AllImage(imageName: "k19", isPro: false),AllImage(imageName: "k20", isPro: true),AllImage(imageName: "k21", isPro: true),AllImage(imageName: "k22", isPro: false),AllImage(imageName: "k23", isPro: true) ,AllImage(imageName: "k24", isPro: false)]
        let image2 = ImageData(ImageC: "Kids", imageModels: allImagesArray)
        imageList.append(image2)

        allImagesArray = [AllImage(imageName: "c1", isPro: true) ,AllImage(imageName: "c2", isPro: false) ,AllImage(imageName: "c3", isPro: true) ,AllImage(imageName: "c4", isPro: false) ,AllImage(imageName: "c5", isPro: false) ,AllImage(imageName: "c6", isPro: false) ,AllImage(imageName: "c7", isPro: false),AllImage(imageName: "c8", isPro: true) ,AllImage(imageName: "c9", isPro: false),AllImage(imageName: "c10", isPro: true),AllImage(imageName: "c11", isPro: false),AllImage(imageName: "c12", isPro: true),AllImage(imageName: "c13", isPro: false),AllImage(imageName: "c14", isPro: false),AllImage(imageName: "c15", isPro: false),AllImage(imageName: "c16", isPro: true),AllImage(imageName: "c17", isPro: false),AllImage(imageName: "c18", isPro: true),AllImage(imageName: "c19", isPro: false),AllImage(imageName: "c20", isPro: true),AllImage(imageName: "c21", isPro: true),AllImage(imageName: "c22", isPro: false)]
        let image3 = ImageData(ImageC: "Cars", imageModels: allImagesArray)
        imageList.append(image3)
           
        allImagesArray = [AllImage(imageName: "07", isPro: true) ,AllImage(imageName: "019", isPro: false) ,AllImage(imageName: "o1", isPro: true) ,AllImage(imageName: "o2", isPro: false) ,AllImage(imageName: "o3", isPro: false) ,AllImage(imageName: "o4", isPro: false) ,AllImage(imageName: "o5", isPro: false),AllImage(imageName: "o6", isPro: true) ,AllImage(imageName: "o7", isPro: false),AllImage(imageName: "o8", isPro: true),AllImage(imageName: "o9", isPro: false),AllImage(imageName: "o10", isPro: true),AllImage(imageName: "o11", isPro: false),AllImage(imageName: "o12", isPro: false),AllImage(imageName: "o13", isPro: false),AllImage(imageName: "o14", isPro: true),AllImage(imageName: "o15", isPro: false),AllImage(imageName: "o16", isPro: true),AllImage(imageName: "o17", isPro: false),AllImage(imageName: "o18", isPro: true),AllImage(imageName: "o19", isPro: true),AllImage(imageName: "o20", isPro: false),AllImage(imageName: "o21", isPro: true),AllImage(imageName: "o22", isPro: false),AllImage(imageName: "o23", isPro: true),AllImage(imageName: "o24", isPro: true),AllImage(imageName: "o25", isPro: false)]
        let image4 = ImageData(ImageC: "Objects", imageModels: allImagesArray)
        imageList.append(image4)

        allImagesArray = [AllImage(imageName: "n1", isPro: true) ,AllImage(imageName: "n2", isPro: false) ,AllImage(imageName: "n3", isPro: true) ,AllImage(imageName: "n4", isPro: false) ,AllImage(imageName: "n5", isPro: false) ,AllImage(imageName: "n6", isPro: false) ,AllImage(imageName: "n7", isPro: false),AllImage(imageName: "n8", isPro: true) ,AllImage(imageName: "n9", isPro: false),AllImage(imageName: "n10", isPro: true),AllImage(imageName: "n11", isPro: false),AllImage(imageName: "n12", isPro: true),AllImage(imageName: "n13", isPro: false),AllImage(imageName: "n14", isPro: false),AllImage(imageName: "n15", isPro: false),AllImage(imageName: "n16", isPro: true),AllImage(imageName: "n17", isPro: false),AllImage(imageName: "n18", isPro: true),AllImage(imageName: "n19", isPro: false),AllImage(imageName: "n20", isPro: true),AllImage(imageName: "n21", isPro: true),AllImage(imageName: "n22", isPro: false),AllImage(imageName: "n23", isPro: true),AllImage(imageName: "n24", isPro: false)]
        let image5 = ImageData(ImageC: "Nature", imageModels: allImagesArray)
        imageList.append(image5)
        
        allImagesArray = [AllImage(imageName: "an1" , isPro: false) , AllImage(imageName: "an2" , isPro: true), AllImage(imageName: "an3" , isPro: false), AllImage(imageName: "an4" , isPro: true) , AllImage(imageName: "an5" , isPro: false) , AllImage(imageName: "an6" , isPro: true) , AllImage(imageName: "an7" , isPro: false), AllImage(imageName: "an8" , isPro: true), AllImage(imageName: "an9" , isPro: false), AllImage(imageName: "an10" , isPro: false), AllImage(imageName: "an11" , isPro: true), AllImage(imageName: "an12" , isPro: true), AllImage(imageName: "an13" , isPro: true),AllImage(imageName: "an14" , isPro: true), AllImage(imageName: "an15" , isPro: true), AllImage(imageName: "an16" , isPro: false), AllImage(imageName: "an17" , isPro: true),AllImage(imageName: "an18" , isPro: false), AllImage(imageName: "an19" , isPro: false), AllImage(imageName: "an20" , isPro: false),AllImage(imageName: "an21" , isPro: false),AllImage(imageName: "Anime" , isPro: true)]
            let image6 = ImageData(ImageC: "Anime", imageModels: allImagesArray)
            imageList.append(image6)
        
        allImagesArray = [AllImage(imageName: "a1" , isPro: false) , AllImage(imageName: "a2" , isPro: true), AllImage(imageName: "a3" , isPro: false), AllImage(imageName: "a4" , isPro: true) , AllImage(imageName: "a5" , isPro: false) , AllImage(imageName: "a6" , isPro: true) , AllImage(imageName: "a7" , isPro: false), AllImage(imageName: "a8" , isPro: true), AllImage(imageName: "a9" , isPro: false), AllImage(imageName: "a10" , isPro: false), AllImage(imageName: "a11" , isPro: true), AllImage(imageName: "a12" , isPro: true), AllImage(imageName: "a13" , isPro: true),AllImage(imageName: "a14" , isPro: true), AllImage(imageName: "a15" , isPro: true), AllImage(imageName: "a16" , isPro: false), AllImage(imageName: "a17" , isPro: true)]
            let image7 = ImageData(ImageC: "Animal", imageModels: allImagesArray)
            imageList.append(image7)
        

        allImagesArray = [AllImage(imageName: "f1" , isPro: false) , AllImage(imageName: "f2" , isPro: true), AllImage(imageName: "f3" , isPro: false), AllImage(imageName: "f4" , isPro: true) , AllImage(imageName: "f5" , isPro: false) , AllImage(imageName: "f6" , isPro: true) , AllImage(imageName: "f7" , isPro: false), AllImage(imageName: "f8" , isPro: true), AllImage(imageName: "f9" , isPro: false), AllImage(imageName: "f10" , isPro: false), AllImage(imageName: "f11" , isPro: true), AllImage(imageName: "f12" , isPro: true), AllImage(imageName: "f13" , isPro: true),AllImage(imageName: "f14" , isPro: true), AllImage(imageName: "f15" , isPro: true), AllImage(imageName: "f16" , isPro: false), AllImage(imageName: "f17" , isPro: true),AllImage(imageName: "f18" , isPro: false), AllImage(imageName: "f19" , isPro: true),AllImage(imageName: "f20" , isPro: false), AllImage(imageName: "f21" , isPro: true)]
            let image8 = ImageData(ImageC: "Food", imageModels: allImagesArray)
            imageList.append(image8)

        allImagesArray = [AllImage(imageName: "Architec" , isPro: false) , AllImage(imageName: "ar2" , isPro: true), AllImage(imageName: "ar3" , isPro: false), AllImage(imageName: "ar4" , isPro: true) , AllImage(imageName: "ar5" , isPro: false) , AllImage(imageName: "ar6" , isPro: true) , AllImage(imageName: "ar7" , isPro: false), AllImage(imageName: "ar8" , isPro: true), AllImage(imageName: "ar9" , isPro: false), AllImage(imageName: "ar10" , isPro: false), AllImage(imageName: "ar11" , isPro: true), AllImage(imageName: "ar12" , isPro: true)]
            let image9 = ImageData(ImageC: "Architec", imageModels: allImagesArray)
            imageList.append(image9)
    }
    @objc func TextButtonPressed() {
        if let TextViewController = storyboard?.instantiateViewController(withIdentifier: "TextViewController") {
            navigationController?.pushViewController(TextViewController, animated: true)
        }
    }
    func updateGradientColor() {
            let colors: [UIColor] = isButtonObjectClicked ? [UIColor.init(hexString: "015bff")!, UIColor.init(hexString: "e67af4")!] : []
        }
    func toggleViewVisibility(isCollectionViewVisible: Bool) {
           myCollectionView.isHidden = !isCollectionViewVisible
           ViewText.isHidden = isCollectionViewVisible
       }
}

extension ImageViewController: UICollectionViewDelegate , UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
       let ImageModels = imageList[indexPath.item].imageModels
        cell.myLabelView.text = imageList[indexPath.row].ImageC
        cell.myImageview.image = UIImage(named: imageList [indexPath.row].ImageC)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
                let vc = storyboard!.instantiateViewController(identifier: "ViewImages") as! ViewImageHome
                vc.allImageList = imageList[indexPath.row].imageModels
                navigationController?.pushViewController(vc, animated: true)
            }
}
// Custom Collectionview Hight Width
extension ImageViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
         return CGSize(width: collectionWidth/3-20, height: collectionWidth/3)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func sideSpace(){
        let layout = UICollectionViewFlowLayout()
        
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            self.myCollectionView?.collectionViewLayout = layout
    }
}
