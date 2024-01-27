//
//  CustomCamereViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 10/01/2024.
//

import UIKit
import AVFoundation
class CustomCamereViewController: UIViewController {

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
    private var panGesture: UIPanGestureRecognizer!
    private var pinchGesture: UIPinchGestureRecognizer!
    private var isFlashOn: Bool = false
    private var captureDevice: AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        previewlayer.backgroundColor = UIColor.systemPurple.cgColor
                view.layer.addSublayer(previewlayer)
                view.addSubview(shutterButton)
//                shutterButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
//                checkCameraPermission()
        
    }
}
