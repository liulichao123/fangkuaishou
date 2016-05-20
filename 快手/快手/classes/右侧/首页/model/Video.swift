//
//  Video.swift
//  swift上传
//
//  Created by liulichao on 16/5/13.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
/**获取的网络数据video模型**/
class Video: NSObject {
    var id: Int?
    var name: String?
    var pubDate: String?
    var scale: Float?
    var shotUrlPath: String?
    var urlPath: String?
    var size: Float?
    var status: Int?
    var timeLength: Float?
    var likes: Int?
    var user: User?
    
   static func instanceWithDict(dict: NSDictionary) -> Video {
        let v = Video()
        v.id = dict["id"]?.integerValue
        v.name = dict["name"] as? String
        v.pubDate = dict["pubDate"] as? String
        v.scale = dict["scale"] as? Float
        v.shotUrlPath = dict["shotUrlPath"] as? String
        v.urlPath = dict["urlPath"] as? String
        v.size = dict["size"] as? Float
        v.status = dict["status"] as? Int
        v.timeLength = dict["timeLength"] as? Float
        v.likes = dict["likes"] as? Int
        let userDict = dict["user"] as? NSDictionary
        v.user = User.instanceWithDict(userDict!)
        return v
    }
    
}
