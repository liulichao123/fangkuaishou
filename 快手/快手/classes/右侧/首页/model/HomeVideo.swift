//
//  HomeVideo.swift
//  快手
//
//  Created by liulichao on 16/5/6.
//  Copyright © 2016年 刘立超. All rights reserved.
//


/**上传视频临时用的video**/
class HomeVideo: NSObject {
    /**video id*/
    var id: Int?
    /**video的url str地址*/
    var videoURLPath: String?
    /**video的截图 URL str地址**/
    var videoShotURLPath: String?
    /**video的原始宽高size*/
    var videoOrginSize: CGSize?
    /**video文件大小 单位MB*/
    var videoDataSize: CGFloat?
    /**video的播放时长*/
    var videoPlayTime: CGFloat?
    /**发送视频的用户**/
    var userId: String?
    /**喜欢数量**/
    var likeCount: Int?
}


