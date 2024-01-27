//
//  ContinueViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 26/12/2023.
//

import UIKit

class ContinueViewController: UIViewController {
    var selectedImage: UIImage?
    @IBOutlet weak var ContinueBackButton: UIButton!
    
    @IBOutlet weak var PassedImageView: UIImageView!
    var imageData = AllImage(imageName: "", isPro: true)
    @IBOutlet weak var ButtonContinue: UIButton!
    var textHasBeenSet = false
    var receivedText: String?
    var receivedFont: UIFont?
    var receivedTextFieldText: String?
    var isProImageSelected = false
    var freeImages: [String]?
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 70)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PassedImageView.image = UIImage(named: imageData.imageName ?? "")
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(textLabel)
        ButtonContinue.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        
        PassedImageView.layer.borderWidth = 1
        PassedImageView.layer.borderColor = UIColor.blue.cgColor
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        if let receivedText = receivedText, !receivedText.isEmpty, let receivedFont = receivedFont {
            configureTextLabel(with: receivedText, font: receivedFont)
            textHasBeenSet = true
        } else {
            PassedImageView.layer.borderWidth = 0
            PassedImageView.layer.borderColor = nil
        }
        
        if let textFieldText = receivedTextFieldText {
            print("Received text from TextFieldView: \(textFieldText)")
        }
        
        
        if !textHasBeenSet {
            if let receivedText = receivedText, !receivedText.isEmpty, let receivedFont = receivedFont {
                configureTextLabel(with: receivedText, font: receivedFont)
                textHasBeenSet = true
            } else {
                PassedImageView.layer.borderWidth = 0
                PassedImageView.layer.borderColor = nil
            }
        }
        
        ContinueBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        self.ButtonContinue.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
    }
    
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func continueButtonPressed() {
        
        //        if imageData.isPro ?? false {
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                   let VC = storyboard.instantiateViewController(withIdentifier: "TryProViewController") as! TryProViewController
        //                   self.navigationController?.pushViewController(VC, animated: true)
        //        }
        //        else {
        //            if let cameraViewController = storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController {
        //                cameraViewController.receivedImage = PassedImageView.image
        //                cameraViewController.receivedText = receivedText
        //                cameraViewController.receivedFont = receivedFont
        //                cameraViewController.selectedImage = selectedImage
        //                if let selectedImage = selectedImage {
        //                    cameraViewController.selectedImage = selectedImage
        //                } else {
        //                    print("Selected image is nil")
        //                }
        //
        //                navigationController?.pushViewController(cameraViewController, animated: true)
        //            }
        //        }
        if imageData.isPro ?? false {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let VC = storyboard.instantiateViewController(withIdentifier: "TryProViewController") as! TryProViewController
              self.navigationController?.pushViewController(VC, animated: true)
          } else {
              if let cameraViewController = storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController {
                  cameraViewController.receivedImage = PassedImageView.image
                  cameraViewController.receivedText = receivedText
                  cameraViewController.receivedFont = receivedFont
                  cameraViewController.selectedImage = selectedImage

                  if let selectedImage = selectedImage {
                      cameraViewController.selectedImage = selectedImage
                  } else {
                      print("Selected image is nil")
                  }
                  if let firstLabel = Label.first {
                      cameraViewController.receivedTextFromFirstIndex = firstLabel.label
                  }

                  navigationController?.pushViewController(cameraViewController, animated: true)
              }
          }
      }

    private func configureTextLabel(with text: String, font: UIFont) {
        textLabel.removeFromSuperview()
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        textLabel.textColor = .black
        textLabel.font = scaledFont
        textLabel.text = text
        
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
