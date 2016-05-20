//
//  Modeltool.swift
//  快手
//
//  Created by liulichao on 16/5/8.
//  Copyright © 2016年 刘立超. All rights reserved.
//

class Modeltool: NSObject {
    static var i: Int = 0
    //根据截图路径返回model
   static func modelWihtImagePath(imagePath: String) -> HomeVideo {
        i = i + 1
        let video = HomeVideo()
        video.id = i
        video.videoShotURLPath = imagePath
    
        return video
    }
    
    //销毁缓存
    static func distoryCache(models: [HomeVideo]){
        let fileManage: NSFileManager = NSFileManager.defaultManager()
        for video in models {
            do{
                try fileManage.removeItemAtPath(video.videoURLPath!)
                try fileManage.removeItemAtPath(video.videoShotURLPath!)
            }catch{
                print(error)
            }
            
        }
    }
}
