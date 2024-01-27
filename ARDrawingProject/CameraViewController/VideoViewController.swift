//
//  VideoViewController.swift
//  ARDrawingProject
//
//  Created by Raza on 28/12/2023.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {


    @IBOutlet weak var VideoView: UIImageView!
    
    @IBOutlet weak var ButtonVideo: UIButton!
   
    
    @IBOutlet weak var CancelButton: UIButton!
    
    var player: AVPlayer!
        var avpController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)

    //  VideoButtonBack.addTarget(self, action: #selector(VideoButtonBackPressed), for: .touchUpInside)
      //  CancelButton.addTarget(self, action: #selector(CancelView), for: touch)
        
        self.ButtonVideo.applyGradient(colors: [UIColor.init(hexString: "015bff")!,UIColor.init(hexString: "e67af4 ")!])
        startvideo()
       // VideoButtonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        ButtonVideo.addTarget(self, action: #selector(VideoButtonPressed), for: .touchUpInside)
        func startvideo() {
            let urlString = "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
            if let url = URL(string: urlString) {
                player = AVPlayer(url: url)
                avpController.player = player
                avpController.view.frame.size.height = VideoView.frame.size.height
                avpController.view.frame.size.width = VideoView.frame.size.width
                self.VideoView.addSubview(avpController.view)
                player.play()
                NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            } else {
                print("Invalid URL")
            }
        }
        
    }
  

    @objc func playerDidFinishPlaying(note: NSNotification) {
           // Perform any actions needed after the video finishes playing
           print("Video finished playing")
       }
   

    @objc func VideoButtonPressed() {
        player.pause()
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

    @objc func VideoButtonBackPressed() {
           player.pause()
           
           player.seek(to: CMTime.zero)
           
          
           if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController {
               navigationController?.pushViewController(nextViewController, animated: true)
           }
       }
    @objc func cancelButtonPressed() {
        player.pause()

        // Optionally, you may want to stop or reset the player, depending on your requirements.
        // player.seek(to: CMTime.zero)
        // player.replaceCurrentItem(with: nil)

        navigationController?.popViewController(animated: true)
    }
}



