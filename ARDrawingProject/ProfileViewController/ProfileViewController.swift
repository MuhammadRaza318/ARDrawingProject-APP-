//
//  ProfileViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 01/01/2024.
//

import UIKit


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    


    @IBOutlet weak var MyDrawingImage: UIImageView!
    @IBOutlet weak var ViewAllBtn: UIButton!
   
    @IBOutlet weak var ViewBtn: UIButton!
    
    @IBOutlet weak var Timelabel: UILabel!
    var receivedImage: UIImage?
    @IBOutlet weak var Profileview: UIView!
    @IBOutlet weak var ProfileBackButton: UIButton!
    private var startTime: Date?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        startTimer()
     
       ProfileBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.Profileview.applyiGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        
        ViewBtn.addTarget(self, action: #selector(viewDrawingButtonPressed), for: .touchUpInside)
        ViewAllBtn.addTarget(self, action: #selector( ViewAllButtonPressed), for: .touchUpInside)
        if let image = receivedImage {
                   MyDrawingImage.image = image
               }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myDrawingImageTapped))
               MyDrawingImage.isUserInteractionEnabled = true
               MyDrawingImage.addGestureRecognizer(tapGestureRecognizer)

    }
    @objc func myDrawingImageTapped() {
           // Show a pop-up message with two buttons
           let alertController = UIAlertController(title: "", message: "What do you want to upload?", preferredStyle: .alert)

           // Add action for the first button
           let firstAction = UIAlertAction(title: "Lesson picture", style: .default) { _ in
               print("First Button Pressed")
           }
           let secondAction = UIAlertAction(title: "Sketch", style: .default) { _ in
               self.showImagePicker()
               
           }

           alertController.addAction(firstAction)
           alertController.addAction(secondAction)
           present(alertController, animated: true, completion: nil)
        
       }

    private func showImagePicker() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }

        // UIImagePickerControllerDelegate method to handle the picked image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                MyDrawingImage.image = pickedImage
            }

            picker.dismiss(animated: true, completion: nil)
        }
    private func startTimer() {
           startTime = Date()
           updateTimelabel()

           // Schedule a timer to update the Timelabel every second
           Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimelabel), userInfo: nil, repeats: true)
      
       }
    @objc func LearningDrawingButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "VIEWViewController") as? VIEWViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

    @objc func viewDrawingButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "VIEWViewController") as? VIEWViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

    @objc func ViewAllButtonPressed() {
        let cameraVC = storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        cameraVC.didFinishTakingPhoto = { [weak self] image in
            // Use 'image' here to set the MyDrawingImage.image
            self?.MyDrawingImage.image = image
        }

        
        let allImages = [MyDrawingImage.image, /* Add other images here */]

        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "ViewAllViewController") as? ViewAllViewController {
            // Pass the array of images to the next view controller
            nextViewController.images = allImages

            navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            print("Error: Unable to instantiate ViewAllViewController from storyboard.")
        }
    }
    

       @objc private func updateTimelabel() {
           guard let startTime = startTime else {
               return
           }

           let elapsedTime = Date().timeIntervalSince(startTime)
           let formattedTime = formatTime(elapsedTime)
           Timelabel.text = formattedTime
       }

       private func formatTime(_ timeInterval: TimeInterval) -> String {
           let formatter = DateComponentsFormatter()
           formatter.allowedUnits = [.hour, .minute, .second]
           formatter.unitsStyle = .abbreviated

           return formatter.string(from: timeInterval) ?? "00:00:00"
       }
    @objc func backButtonPressed() {
           
            self.navigationController?.popViewController(animated: true)
        }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            applyCornerRadius()
        }
    private func applyCornerRadius() {
            Profileview.layer.cornerRadius = 30
            Profileview.layer.masksToBounds = true
        }
    
    

}
extension UIView {
    func applyiGradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
