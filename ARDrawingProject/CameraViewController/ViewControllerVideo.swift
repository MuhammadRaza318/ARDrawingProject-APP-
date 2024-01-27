//
//  ViewController.swift
//  collectionView4
//
//  Created by Raza on 17/11/2023.
//

import UIKit
import AVKit
import AVFoundation


class ViewControllerVideo: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    var player : AVPlayer!
    var avpController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startvideo()
        func startvideo() {
            let urlString = "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
            if let url = URL(string: urlString) {
                player = AVPlayer(url: url)
                avpController.player = player
                avpController.view.frame.size.height = thumbnailImageView.frame.size.height
                avpController.view.frame.size.width = thumbnailImageView.frame.size.width
                self.thumbnailImageView.addSubview(avpController.view)
                player.play()
            } else {
                print("Invalid URL")
            }
        }
        
    }
}
