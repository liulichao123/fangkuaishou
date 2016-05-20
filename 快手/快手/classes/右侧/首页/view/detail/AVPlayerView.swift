//
//  AVPlayerView.swift
//  快手
//
//  Created by liulichao on 16/5/8.
//  Copyright © 2016年 刘立超. All rights reserved.
//
import AVFoundation

class AVPlayerView: UIView {
    var player : AVPlayer {
        
        get {
            let layer = self.layer as! AVPlayerLayer
            return layer.player!
        }
        
        set(newPlayer) {
            
            let layer = self.layer as! AVPlayerLayer
            layer.player = newPlayer
        }
    }
    
    override class func layerClass() -> AnyClass {
        return AVPlayerLayer.self
    }
}
