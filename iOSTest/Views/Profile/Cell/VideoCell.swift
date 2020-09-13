//
//  VideoCell.swift
//  iOSTest
//
//  Created by Smith Huamani Hilario on 9/12/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import AVKit

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var sangNameLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var mediaType: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        mainView.layer.cornerRadius = 10.0
        photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
    }
    
    public var video: Video? = nil {
        didSet {
            
            guard let `video` = video,
                let string = video.recordVideo,
                let url = URL(string: string)  else { return }
            
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds
            playerLayer?.videoGravity = .resize
            videoImageView.layer.addSublayer(playerLayer!)
            
            guard let profile = video.profile, let image = profile.image, let imageUrl = URL(string: image) else { return }
            
            sangNameLabel.text = "\(profile.username) sang \(profile.name)"
            songLabel.text = profile.name

            downloadImage(from: imageUrl)
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func videoPressedButton() {
        
        guard let `player` = player else { return }
        
        if !playImageView.isHidden {
            player.play()
            playImageView.isHidden = true
        } else {
            player.pause()
            playImageView.isHidden = false
        }
    }
    
    
    // MARK: - Image Download
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.photoImageView.image = UIImage(data: data)
            }
        }
    }
        
}
