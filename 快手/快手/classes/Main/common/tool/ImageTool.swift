//
//  ImageTool.swift
//  快手
//
//  Created by liulichao on 16/5/8.
//  Copyright © 2016年 刘立超. All rights reserved.
//


class ImageTool: NSObject {
    /**
     保存image到沙盒Caches，返回图片路径
     */
   static func imageWriteTifile(image: UIImage) -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
        let formate = NSDateFormatter()
        formate.dateFormat = "yyyymmddhhMMss"
        let fileName = formate.stringFromDate(NSDate())
        let filePath = cachePath?.stringByAppendingString("/\(fileName).png")
        UIImagePNGRepresentation(image)?.writeToFile(filePath!, atomically: true)
        return filePath!
    }
}
