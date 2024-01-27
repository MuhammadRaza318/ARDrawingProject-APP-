//
//  ViewImageHome.swift
//  ARDrawingProject
//
//  Created by Raza on 28/12/2023.
//

import UIKit

class ViewImageHome: UIViewController {

    @IBOutlet weak var ButtonFree: UIButton!
    @IBOutlet weak var ProButton: UIButton!
    @IBOutlet weak var freeButton: UIView!
    @IBOutlet weak var ButtonAll: UIButton!
    @IBOutlet weak var BackViewImageHomeButton: UIButton!
    @IBOutlet weak var myCollectionView2: UICollectionView!
    var isHeartSelected: Bool = false
    var isProImageSelected = false
    var allImageList = [AllImage]()
    var imageList = [AllImage]()
    var isFreeButtonSelected: Bool = true
    private let spacing:CGFloat = 8
    var currentCategory: ImageData?
    var favoritedImages : [ARDrawing] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        sideSpace()
        imageList = allImageList
        ButtonAll.layer.borderWidth = 2
        ButtonAll.layer.borderColor = UIColor.blue.cgColor
        self.navigationController?.isNavigationBarHidden = true
        BackViewImageHomeButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
   
    @IBAction func allButton(_ sender: Any) {
        updateButtonAppearance(selectedButton: ButtonAll, deselectedButtons: [ButtonFree, ProButton])
        imageList = allImageList
    }
    
    @IBAction func FreeButton(_ sender: UIButton) {
        //high order func
        print("Free Button Pressed")
        imageList.removeAll()
        for i in allImageList{
            if  !(i.isPro ?? false)  {
                imageList.append(i)
            }
        }
        updateButtonAppearance(selectedButton: ButtonFree, deselectedButtons: [ButtonAll, ProButton])
           }
    @IBAction func ProButton(_ sender: Any) {

        print("Pro Button Pressed")
        imageList.removeAll()
        for i in allImageList{
            if  (i.isPro ?? false)  {
                imageList.append(i)
            }
        }
        
        updateButtonAppearance(selectedButton: ProButton, deselectedButtons: [ButtonAll, ButtonFree])
}
    
    
    @objc func backButtonPressed() {
         
            self.navigationController?.popViewController(animated: true)
        }

    @IBAction func heartButton(_ sender: Any) {
        //        if let button = sender as? UIButton {
        //               button.isSelected.toggle()
        //               isHeartSelected = button.isSelected
        //
        //               if isHeartSelected {
        //                   let imageNameToShow = "imageHeart"
        //                   print("show image: \(imageNameToShow)")
        //                   button.setImage(UIImage(named: imageNameToShow), for: .normal)
        //               } else {
        //                   print("no image")
        //                   button.setImage(nil, for: .normal)
        //               }
        //           }
        
        guard let indexPath = indexPathForButton(sender as! UIButton) else {
            return
        }
        
        
        let favoritedImage = imageList[indexPath.row]
        
        if let button = sender as? UIButton {
            button.isSelected.toggle()
            isHeartSelected = button.isSelected
            
            if isHeartSelected {
                let imageNameToShow = "imageHeart"
                print("show image: \(imageNameToShow)")
                button.setImage(UIImage(named: imageNameToShow), for: .normal)
                
                
                CoreDataHelper.shared.saveFavoriteImage(imageData: favoritedImage)
            } else {
                print("no image")
                button.setImage(nil, for: .normal)
                
                //     CoreDataHelper.shared.removeFavoriteImage(imageData: imageList)
                
            }
                    }
        
    }
//    @objc func clickheartButton(sender:UIButton) {
//        
//        // two method
//        // save model
//        CoreDataHelper.shared.saveFavoriteImage(imageData: imageList[sender.tag])
//        
//    }
        func indexPathForButton(_ button: UIButton) -> IndexPath? {
            let point = button.convert(CGPoint.zero, to: myCollectionView2)
            return myCollectionView2.indexPathForItem(at: point)
        }
        
        func updateButtonAppearance(selectedButton: UIButton, deselectedButtons: [UIButton]) {
            myCollectionView2.reloadData()
            selectedButton.layer.borderColor = UIColor.blue.cgColor
            selectedButton.layer.borderWidth = 2.0
            
            for button in deselectedButtons {
                button.layer.borderColor = UIColor.clear.cgColor
                button.layer.borderWidth = 0.0
            }
        }
    }

extension ViewImageHome: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell = myCollectionView2.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! MyCollectionViewCell2
            cell.heartButton.isSelected = isHeartSelected
           let currentImage = imageList[indexPath.row]

      //  cell.heartButton.addTarget(self, action:#selector(clickheartButton), for: .touchUpInside)
        cell.heartButton.tag = indexPath.row
         // gobal array all image check high oder function goabl and my cuurent name exssit and show heart and otherwise emty
        //if
            cell.myImageView2.image = UIImage(named: currentImage.imageName ?? "")
            cell.heartButton.isSelected = isHeartSelected
            if currentImage.isPro ?? false {
                
                cell.ProImageIcon.isHidden = false
            } else {
                
                cell.ProImageIcon.isHidden = true
            }
            return cell
        
        
      
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "ContinueViewController") as! ContinueViewController
        desVC.imageData = imageList[indexPath.row]
        self.navigationController?.pushViewController(desVC, animated: true)
    }
}

extension ViewImageHome:UICollectionViewDelegateFlowLayout{
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
            self.myCollectionView2?.collectionViewLayout = layout
    }
}
