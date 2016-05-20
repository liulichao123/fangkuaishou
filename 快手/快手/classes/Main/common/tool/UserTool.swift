//
//  UserTool.swift
//  快手
//
//  Created by liulichao on 16/5/11.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit


//单例写法1 （单行单例。最简单方法）
class UserTool: NSObject {
    let user: User! = User()
    static let sharedInstance: UserTool = UserTool()
}


//单例写法2
//class UserTool: NSObject {
//    private static let sharedInstance: UserTool = UserTool()
//    class var sharedUserTool: UserTool {
//        return sharedInstance
//    }
//}