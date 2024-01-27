//
//  DashBoardViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 15/12/2023.
//

import UIKit

class DashBoardViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var DashBoardImageSelect: UIImageView!
    @IBOutlet weak var HeartProfile: UIButton!
    
    @IBOutlet weak var ProfileButton: UIButton!
    
    @IBOutlet weak var TryProbutton: UIButton!
    @IBOutlet weak var ButtonLearningDrawing: UIButton!
    @IBOutlet weak var ButtonStartDrawing: UIButton!
    
    @IBOutlet weak var ButtonTry: UIButton!
    @IBOutlet weak var ButtonCreateWithAI: UIButton!
    @IBOutlet weak var HomeScreen: UIView!
    @IBOutlet weak var LeraningArdrawing: UIButton!
    
   
    @IBOutlet weak var ButtonBackDashBoard: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.isNavigationBarHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dashBoardImageTapped))
               DashBoardImageSelect.isUserInteractionEnabled = true
               DashBoardImageSelect.addGestureRecognizer(tapGestureRecognizer)
           
        // ButtonBackDashBoard action
//                ButtonBackDashBoard.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        ButtonStartDrawing.addTarget(self, action: #selector(startDrawingButtonPressed), for: .touchUpInside)
        ButtonBackDashBoard.addTarget(self, action: #selector(BackButtonPressed), for: .touchUpInside)
        HeartProfile.addTarget(self, action: #selector(HeartDrawingButtonPressed), for: .touchUpInside)
        ButtonLearningDrawing.addTarget(self, action: #selector(LearningDrawingButtonPressed), for: .touchUpInside)
        ProfileButton.addTarget(self, action: #selector(ProfileButtonPressed), for: .touchUpInside)
      TryProbutton.addTarget(self, action: #selector(TryButtonPressed), for: .touchUpInside)
        ButtonCreateWithAI.setTitle("TRY PRO", for: .normal)
       // ButtonTry.titleLabel?.font =  UIFont.init(name: "Helvetica", size:70)
        ButtonTry.titleLabel!.font = UIFont(name: "Montserrat Thin Medium ", size: 70.0)
//        initialSetup()
              
        HeartProfile.addTarget(self, action: #selector(heartProfileButtonPressed), for: .touchUpInside)
        //Button Color
        
        self.ButtonCreateWithAI.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        
        self.ButtonTry.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        ButtonCreateWithAI.titleLabel?.font = UIFont(name: "Helvetica", size: CGFloat(20))
        ButtonStartDrawing.layer.borderWidth = 1
        ButtonStartDrawing.layer.borderColor = UIColor.blue.cgColor
        ButtonLearningDrawing.layer.borderWidth = 1
        ButtonLearningDrawing.layer.borderColor = UIColor.blue.cgColor
        
        ButtonTry.titleLabel?.font =  UIFont(name: "Poppins", size: 60)

    }
    @objc func dashBoardImageTapped() {
        showImagePicker()
    }

    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DashBoardImageSelect.image = pickedImage

           
            if let continueViewController = storyboard?.instantiateViewController(withIdentifier: "ContinueViewController") as? ContinueViewController {
                navigationController?.pushViewController(continueViewController, animated: true)
            }
        }

        picker.dismiss(animated: true, completion: nil)
    }

    @objc func BackButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func startDrawingButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "CustomTabViewController") as? CustomTabViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        
        }
    }
    @objc func HeartDrawingButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "FavoritedViewController") as? FavoritedViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

    @objc func LearningDrawingButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "LessonTabelViewController") as? LessonTabelViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    @objc func ProfileButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    @objc func TryButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "TryProViewController") as? TryProViewController {
               nextViewController.modalPresentationStyle = .overFullScreen
                present(nextViewController, animated: true, completion: nil)
            }
    }
    @objc func heartProfileButtonPressed() {
        HeartProfile.backgroundColor = UIColor.yellow
        HeartProfile.layer.cornerRadius = 48
    }

}



extension UIButton {
    func applyGradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIView {
    func roundCornerView(corners: UIRectCorner, raduis: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: .init(width: raduis, height: raduis))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


