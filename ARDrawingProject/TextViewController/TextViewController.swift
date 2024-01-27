//
//  TextViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 30/12/2023.
//

import UIKit

class TextViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textTabBarItem: UITabBarItem!
    @IBOutlet weak var TextContinueBackButton: UIButton!
    @IBOutlet weak var ContinueTextButton: UIButton!
    @IBOutlet weak var TextFeildView: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedFont: UIFont = UIFont.systemFont(ofSize: 30)
    var selectedFontName: String = "Helvetica"
    private let spacing:CGFloat = 16
    var labels: [Textlabele] = []
    var selectedLabel: Textlabele?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        sideSpace()
//        textTabBarItem.translatesAutoresizingMaskIntoConstraints = true
        let additionalText = TextFeildView.text ?? ""
        let receivedText = (selectedLabel?.label ?? "") + additionalText
       TextFeildView.font = selectedFont
        TextFeildView.delegate = self
        labels = Label
        TextFeildView.delegate = self
        
        self.ContinueTextButton.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        TextFeildView.layer.borderWidth = 1
        TextFeildView.layer.borderColor = UIColor.blue.cgColor
        
        TextContinueBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        TextFeildView.resignFirstResponder()
    }
    func updateFont() {
        if let selectedLabel = selectedLabel {
            TextFeildView.font = UIFont(name: selectedLabel.fontName, size: 30)
        } else {
            TextFeildView.font = UIFont(name: selectedFontName, size: 30)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateFont()  
        return true
    }
    @objc func backButtonPressed() {
        // Back Button
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ContinueButtonPress(_ sender: Any) {

        TextFeildView.resignFirstResponder()

            guard let continueViewController = storyboard?.instantiateViewController(withIdentifier: "ContinueViewController") as? ContinueViewController else {
                return
            }

            guard let additionalText = TextFeildView.text, !additionalText.isEmpty else {
                showAlert(message: "Please fill in the text field.")
                return
            }

            let selectedFont = selectedLabel.flatMap { UIFont(name: $0.fontName, size: 30) } ?? UIFont.systemFont(ofSize: 30)

            let generatedImage = textToImage(drawText: additionalText, inImage: UIImage()) // Pass only the additional text
            continueViewController.receivedText = additionalText
            continueViewController.receivedFont = selectedFont
            navigationController?.pushViewController(continueViewController, animated: true)
        }

    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
extension TextViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return Label.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Call = collectionView.dequeueReusableCell(withReuseIdentifier: "TextViewCollectionViewCell", for: indexPath) as! TextViewCollectionViewCell
   
        let isIconHidden = indexPath.item == 0
               Call.setup(with: Label[indexPath.row], isIconHidden: isIconHidden)

               return Call
       
    }
}
extension TextViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedLabelText = labels[indexPath.row].label
            self.selectedLabel = Textlabele(label: selectedLabelText, fontName: labels[indexPath.row].fontName)

            TextFeildView.text = selectedLabelText
            updateFont()
        }
    }
func textToImage(drawText text: String, inImage image: UIImage) -> UIImage {
    guard let cgImage = image.cgImage else {
      
        return UIImage()
    }

    let textColor = UIColor.black
    let textFont = UIFont.systemFont(ofSize: 60)

    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

    let context = UIGraphicsGetCurrentContext()
    context?.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: image.size))

    let textFontAttributes: [NSAttributedString.Key: Any] = [
        .font: textFont,
        .foregroundColor: textColor,
    ]

    let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
    text.draw(in: rect, withAttributes: textFontAttributes)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage ?? UIImage()
    
}
extension String {
    func size(withFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return size
    }
}

extension TextViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
         return CGSize(width: collectionWidth/2-30, height: 34)
        
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
            self.collectionView?.collectionViewLayout = layout
        
    }
    
}


