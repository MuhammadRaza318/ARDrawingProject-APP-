//
//  CameraViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 28/12/2023.
//

import UIKit
import AVFoundation
class CameraViewController: UIViewController {
    var selectedImage: UIImage?
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewlayer = AVCaptureVideoPreviewLayer()
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor . purple.cgColor
        return button
    }()
    
    @IBOutlet weak var VideoViewController: UIButton!
    @IBOutlet weak var FlashLightBtton: UIButton!
    @IBOutlet weak var CameraBttonClick: UIButton!
    @IBOutlet weak var zoomBtton: UIButton!
    @IBOutlet weak var ButonOpacity: UIButton!
    
    @IBOutlet weak var CustomCamereImageView: UIImageView!
    var receivedTextFromFirstIndex: String?

    var isCustomCameraOn: Bool = true
    
    var takePicture = false
    @objc func captureImage(_ sender: UIButton?){
            takePicture = true
        }
        
    @IBOutlet weak var OpacityShow: UIView!
    @IBOutlet weak var CameraBackButton: UIButton!
    @IBOutlet weak var ImageViewCamera: UIImageView!
    private var panGesture: UIPanGestureRecognizer!
    private var pinchGesture: UIPinchGestureRecognizer!
    private var isFlashOn: Bool = false
    private var captureDevice: AVCaptureDevice?
    @IBOutlet weak var CameraView: UIView!
    
    var didFinishTakingPhoto: ((UIImage?) -> Void)?


    let slider = UISlider()
    var receivedImage: UIImage?
    var receivedText: String?
    var receivedFont: UIFont?
   
    let textLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 40)
         return label
     }()
    private var rotationAngle: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        previewlayer.frame = CustomCamereImageView.bounds
        previewlayer.session = session
        CustomCamereImageView.layer.addSublayer(previewlayer)
        view.addSubview(shutterButton)
        shutterButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        checkCameraPermission()
        setupSlider()
              setupPanGesture()
              setupPinchGesture()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        ImageViewCamera.addGestureRecognizer(panGesture)
              ImageViewCamera.layer.borderWidth = 1
              ImageViewCamera.layer.borderColor = UIColor.blue.cgColor
        VideoViewController.addTarget(self, action: #selector(VideoViewButtonPressed), for: .touchUpInside)
              view.addSubview(textLabel)

              self.navigationController?.isNavigationBarHidden = true
              NotificationCenter.default.addObserver(
                          self,
                          selector: #selector(handleAVCaptureSessionError),
                          name: .AVCaptureSessionRuntimeError,
                          object: nil
                      )
                  
              NSLayoutConstraint.activate([
                         textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                         textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                     ])
              if let receivedText = receivedText, !receivedText.isEmpty, let receivedFont = receivedFont {
                  configureTextLabel(with: receivedText, font: receivedFont)
              } else {
                  ImageViewCamera.layer.borderWidth = 0
                  ImageViewCamera.layer.borderColor = nil
              }

              CameraBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
              ButonOpacity.addTarget(self, action: #selector(buttonOpacityPressed), for: .touchUpInside)
              CameraBttonClick.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)

              
              if let receivedText = receivedText {
                        
                         textLabel.text = receivedText
                     }
              if let image = receivedImage {
                  
                  ImageViewCamera.image = image
              }
              if let device = AVCaptureDevice.default(for: .video) {
                         captureDevice = device
                         FlashLightBtton.isHidden = !device.hasTorch
                     }

                     FlashLightBtton.addTarget(self, action: #selector(flashButtonPressed), for: .touchUpInside)

              
          }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewlayer.frame = CustomCamereImageView.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height -  100)
    }
    @objc func VideoViewButtonPressed() {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    private func checkCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case.notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async{
                    self?.setUpCamere()
                }
            }
        case.restricted:
            break
        case.denied:
            break
        case.authorized:
          setUpCamere()
        @unknown default :
            break
            
        }
    }
    private func setUpCamere() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video){
            do{
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                
                previewlayer.videoGravity = .resizeAspectFill
                previewlayer.session = session
                
                
                session.startRunning()
                self.session = session
            }
            catch{
                print(error)
            }
        }
        func didTapTakePhoto() {
            output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        }
        
    }

          private func configureTextLabel(with text: String, font: UIFont) {
                 textLabel.removeFromSuperview()
                 textLabel.translatesAutoresizingMaskIntoConstraints = false
                 textLabel.textAlignment = .center
                 textLabel.textColor = .black
                 textLabel.font = font
                 textLabel.text = text

                 view.addSubview(textLabel)

                 NSLayoutConstraint.activate([
                     textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                     textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                 ])
             }

          
          func setupPinchGesture() {
                 pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
                 ImageViewCamera.isUserInteractionEnabled = true
                 ImageViewCamera.addGestureRecognizer(pinchGesture)
             }
          
          @objc func handleAVCaptureSessionError(notification: Notification) {
                  if let error = notification.userInfo?[AVCaptureSessionErrorKey] as? NSError {
                      print("AVCaptureSession error: \(error.localizedDescription)")
                  }
              }
              deinit {
                  NotificationCenter.default.removeObserver(self, name: .AVCaptureSessionRuntimeError, object: nil)
              }
          
          @objc func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
                 guard sender.view != nil else { return }

              switch sender.state {
                      case .changed, .ended:
                          // Update the transform of the image view based on the pinch gesture
                          ImageViewCamera.transform = ImageViewCamera.transform.scaledBy(x: sender.scale, y: sender.scale)
                          sender.scale = 1.0

                      default:
                          break
                      }
                 if sender.state == .changed {
                     let currentScale = sender.view!.layer.value(forKeyPath: "transform.scale") as! CGFloat
                     let newScale = currentScale * sender.scale
                     let minScale: CGFloat = 0.5
                     let maxScale: CGFloat = 2.0

                     let scaledValue = min(max(newScale, minScale), maxScale)

                     sender.view?.transform = CGAffineTransform(scaleX: scaledValue, y: scaledValue)
                     sender.scale = 1.0
                 }
             }
          
                  func setupSlider(){
                      slider.minimumValue = 0
                      slider.maximumValue = 1
              
                      slider.value = 1
                      slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
                      slider.translatesAutoresizingMaskIntoConstraints = false
                      slider.tintColor = .systemRed
                      slider.minimumTrackTintColor = .purple
                      view.addSubview(slider)
                      textLabel.alpha = CGFloat(slider.value)
                      slider.widthAnchor.constraint(equalToConstant: 350).isActive = true

                      NSLayoutConstraint.activate([
                          slider.topAnchor.constraint(equalTo: ImageViewCamera.bottomAnchor, constant: 80),
                          slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
                          slider.widthAnchor.constraint(equalToConstant: 190)
                      ])
              
                  }
          @objc func cameraButtonPressed() {
                  openCamera()
              }

          func openCamera() {
                 let imagePicker = UIImagePickerController()
                 imagePicker.delegate = self
                 imagePicker.sourceType = .camera
                 imagePicker.cameraCaptureMode = .photo
                 isCustomCameraOn = true
                 present(imagePicker, animated: true, completion: nil)
             }

          @objc func flashButtonPressed() {
                 toggleFlash()
             }

             private func toggleFlash() {
                 do {
                     try captureDevice?.lockForConfiguration()

                     if isFlashOn {
                         captureDevice?.torchMode = .off
                         print("FlashOFF")
                     } else {
                         captureDevice?.torchMode = .on
                         print("FlashON")
                     }

                     captureDevice?.unlockForConfiguration()
                     isFlashOn.toggle()

                 } catch {
                     print("Error toggling flash: \(error)")
                 }
             }
          func setupPanGesture() {
                  panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
                  ImageViewCamera.isUserInteractionEnabled = true
                  ImageViewCamera.addGestureRecognizer(panGesture)
              }

              @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
//                 guard sender.view != nil else { return }
//               //   guard let imageView = sender.view else { return }
//
//                  if sender.state == .began || sender.state == .changed {
//                      let translation = sender.translation(in: self.view)
//                      sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
//                      sender.setTranslation(CGPoint.zero, in: self.view)
//                  }
//                  let translation = sender.translation(in: view)
//
//                          switch sender.state {
//                          case .changed:
//                             
//                              rotationAngle += translation.x / 100.0
//                              view.transform = CGAffineTransform(rotationAngle: rotationAngle)
//                              sender.setTranslation(.zero, in: view)
//
//                          case .ended: break
//                          default:
//                              break
//                          }
                  guard sender.view != nil else { return }

                      if sender.state == .began || sender.state == .changed {
                          let translation = sender.translation(in: view)
                          sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
                          sender.setTranslation(CGPoint.zero, in: view)
                      }

                      switch sender.state {
                      case .changed:
                          let translation = sender.translation(in: ImageViewCamera)

                          rotationAngle += translation.x / 100.0
                          ImageViewCamera.transform = CGAffineTransform(rotationAngle: rotationAngle)
                          sender.setTranslation(.zero, in: ImageViewCamera)

                      case .ended:
                          break
                      default:
                          break
                      }
              }

          @objc func buttonOpacityPressed() {
                OpacityShow.isHidden = !OpacityShow.isHidden
                  slider.isHidden = OpacityShow.isHidden
            }


          @objc func sliderValueChanged(_ sender: UISlider){
                  ImageViewCamera.alpha = CGFloat(sender.value)
                  textLabel.alpha = CGFloat(sender.value)
              }
              
    @objc func backButtonPressed() {
        for viewController in navigationController?.viewControllers ?? [] {
            if let ViewImageHome = viewController as? ViewImageHome {
                navigationController?.popToViewController(ViewImageHome, animated: true)
                return
            }
        }
        showConfirmationAlert()
    }
    func showConfirmationAlert() {
        let alertController = UIAlertController(title: "Confirm Exit", message: "Are you sure you want to exit?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            
            self?.navigationController?.popViewController(animated: true)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
              
          }

      extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
          
          func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
              picker.dismiss(animated: true, completion:  nil)
              
          }
         
          func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
              picker.dismiss(animated: true, completion: nil)

              if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                  didFinishTakingPhoto?(image)
              } else {
                  print("Error: Unable to retrieve the image.")
              }
          }
      }
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        let image  = UIImage(data: data)
        
        session?.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
}



