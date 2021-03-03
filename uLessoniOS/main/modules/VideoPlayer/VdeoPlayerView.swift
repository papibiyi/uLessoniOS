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
    var timer: Timer?
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
    }
    
    func play(){
        if avPlayer?.rate == 1 { return }
        avPlayer?.play()
    }
    
    func pause(){
        avPlayer?.pause()
    }
    
    func deinitalize(){
        self.timer = nil
        self.avPlayer = nil
        self.playerLooper = nil
    }
    
    private func setupControlView() {
        setupTapActions()
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
        view.addSubview(currentTimeLabel)
        view.addSubview(slider)
        view.addSubview(totalDurationLabel)

        
        pausePlayContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pausePlayContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        rewindView.rightAnchor.constraint(equalTo: pausePlayContainer.leftAnchor, constant: -30).isActive = true
        rewindView.centerYAnchor.constraint(equalTo: pausePlayContainer.centerYAnchor).isActive = true

        fowardView.leftAnchor.constraint(equalTo: pausePlayContainer.rightAnchor, constant: 30).isActive = true
        fowardView.centerYAnchor.constraint(equalTo: pausePlayContainer.centerYAnchor).isActive = true

        currentTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        currentTimeLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor).isActive = true
        
        slider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 20).isActive = true
        slider.rightAnchor.constraint(equalTo: totalDurationLabel.leftAnchor, constant: -20).isActive = true
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

        totalDurationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        totalDurationLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor).isActive = true
        
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
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let fowardView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "foward_logo")
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let slider: UISlider = {
        let view = UISlider()
        view.minimumValue = 0
        view.maximumValue = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "\t"
        label.font = UIFont.of(type: Font.Mulish.bold.rawValue, size: 10)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "\t"
        label.font = UIFont.of(type: Font.Mulish.bold.rawValue, size: 10)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    lazy var pausePlayLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: (avPlayer?.rate == 1) ? "pause_logo" : "play_logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    @objc private func onControlViewTap(){
        updateSlider()
        controlViewHidden = !controlViewHidden
        controlContainer.isHidden = controlViewHidden
        timer = controlViewHidden ? nil : Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        pausePlayLogo.image = UIImage(named: (avPlayer?.rate == 1) ? "pause_logo" : "play_logo")
        controlViewContainer.backgroundColor = controlViewHidden ? .clear : UIColor.black.withAlphaComponent(0.3)
    }
    
    @objc private func onFowardPressed(){
        guard let duration = player?.currentItem?.duration else { return }
        guard let cTime = player?.currentTime() else {return}
        let currentTime = CMTimeGetSeconds(cTime)
        let newTime = currentTime + 10.0
        if newTime < (CMTimeGetSeconds(duration) - 10.0){
            let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
            player?.seek(to: time)
        }
        updateSlider()
    }
    
    @objc private func onRewindPressed(){
        guard let cTime = player?.currentTime() else {return}
        let currentTime = CMTimeGetSeconds(cTime)
        var newTime = currentTime - 10.0
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        player?.seek(to: time)
        updateSlider()
    }
    
    @objc private func playPausedPressed(){
        if avPlayer?.rate == 1 {
            pause()
        }else {
            play()
        }
        pausePlayLogo.image = UIImage(named: (avPlayer?.rate == 1) ? "pause_logo" : "play_logo")
    }
    
    @objc private func updateSlider(){
        let duration : CMTime = player?.currentItem?.duration ?? CMTime()
        let currentTime : CMTime = player?.currentTime() ?? CMTime()
        currentTimeLabel.text = getRedableTime(time: currentTime)
        totalDurationLabel.text = getRedableTime(time: duration)
        let value = CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration)
        if player?.rate == 1 {
            slider.value = Float(value)
        }
    }
    
    func getRedableTime(time: CMTime?) -> String? {
        guard let time = time else {return nil}
        let durationTime = CMTimeGetSeconds(time)
        let minutes = durationTime.truncatingRemainder(dividingBy: 3600) / 60
        let seconds = durationTime.truncatingRemainder(dividingBy: 60)
        let mS = "\("\(minutes)".split(separator: ".")[0])"
        let sS = "\("\(seconds)".split(separator: ".")[0])"
        let redable = "\(mS):\(sS)"
        return (redable == "nan:nan") ? "0.0" : redable
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        slider.maximumValue = Float(CMTimeGetSeconds(player?.currentItem?.duration ?? CMTime()))
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player?.seek(to: targetTime)
    }


    
    private func setupTapActions(){
        controlViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onControlViewTap)))
        fowardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFowardPressed)))
        rewindView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onRewindPressed)))
        pausePlayContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playPausedPressed)))
        slider.addTarget(self, action: #selector(self.playbackSliderValueChanged(_:)), for: .valueChanged)
    }
}

