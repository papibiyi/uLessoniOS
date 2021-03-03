//
//  VideoPlayerView.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 20/02/2021.
//  Copyright © 2021 weathen. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    var controlViewHidden = true
    var avPlayer: AVQueuePlayer?
    let applicationWindow =  UIApplication.shared.windows.first!.rootViewController!.view!
    var playerLooper: AVPlayerLooper?
    
    init() {
        super.init(frame: .init(x: 0, y: 0, width: applicationWindow.frame.width, height: 250))
        self.playerLayer.videoGravity = .resizeAspectFill
        setupControlView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
      return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
      return layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
      get {
        return playerLayer.player
      }

      set {
        playerLayer.player = newValue
      }
    }
    
    func insertItem(url: String) {
        if avPlayer?.rate == 1 { return }

        guard let url = URL(string: url) else {return}
        let playerItem = AVPlayerItem(url: url)
        
        avPlayer = AVQueuePlayer(items: [playerItem])
        self.player = avPlayer
        
        self.playerLooper = AVPlayerLooper(player: (self.player as? AVQueuePlayer)!, templateItem: playerItem)
        
        avPlayer?.automaticallyWaitsToMinimizeStalling = true
        avPlayer?.isMuted = true

    }
    
    func play(){
        if avPlayer?.rate == 1 { return }
        avPlayer?.play()
    }
    
    func pause(){
        avPlayer?.pause()
    }
    
    func deinitalize(){
        self.avPlayer = nil
        self.playerLooper = nil
    }
    
    private func setupControlView() {
        setupTapActionOnControlView()
        addSubview(controlViewContainer)
        
        controlViewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        controlViewContainer.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        controlViewContainer.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        controlViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    lazy var controlViewContainer: UIView = {
        let view = UIView()
        
        view.addSubview(controlContainer)
        controlContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controlContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controlContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controlContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var controlContainer: UIView = {
        let view = UIView()
        view.isHidden = controlViewHidden
        view.addSubview(pausePlayContainer)
        view.addSubview(rewindView)
        view.addSubview(fowardView)
        
        pausePlayContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pausePlayContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        rewindView.rightAnchor.constraint(equalTo: pausePlayContainer.leftAnchor, constant: -30).isActive = true
        rewindView.centerYAnchor.constraint(equalTo: pausePlayContainer.centerYAnchor).isActive = true

        fowardView.leftAnchor.constraint(equalTo: pausePlayContainer.rightAnchor, constant: 30).isActive = true
        fowardView.centerYAnchor.constraint(equalTo: pausePlayContainer.centerYAnchor).isActive = true

        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pausePlayContainer: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pod_logo")
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pausePlayLogo)
        pausePlayLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pausePlayLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    let rewindView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rewind_logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let fowardView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "foward_logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    lazy var pausePlayLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: (avPlayer?.rate == 1) ? "pause_logo" : "play_logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    @objc private func onControlViewTap(){
        controlViewHidden = !controlViewHidden
        controlContainer.isHidden = controlViewHidden
        pausePlayLogo.image = UIImage(named: (avPlayer?.rate == 1) ? "pause_logo" : "play_logo")
        controlViewContainer.backgroundColor = controlViewHidden ? .clear : UIColor.black.withAlphaComponent(0.3)
    }
    
    private func setupTapActionOnControlView(){
        controlViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onControlViewTap)))
    }
}

