//
//  common.swift
//  快手
//
//  Created by liulichao on 16/5/4.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import Foundation

//MARK:屏幕大小
/**屏幕大小**/
let ScreenSize = UIScreen.mainScreen().bounds.size
//MARK:状态栏大小
/**状态栏大小**/
let statusBarSize: CGSize = UIApplication.sharedApplication().statusBarFrame.size
//MARK:定义日志输出函数
func printLog<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
    //release时将会成为空方法，新版LLVM编译器将会略掉该方法
//    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
//    #endif
}

//MARK:用户键
/**用户名key**/
let UserPhoneKey = "UserPhoneKey"
/**用户密码key**/
let UserPwdKey = "UserPwdKey"
/**用户idkey**/
let UserIdKey = "UserIdKey"

//MARK:按钮通知
/**左上角按钮点击事件通知**/
let leftBtnClickNotificatioin = "leftBtnClickNotificatioin"
/**左侧按钮点击事件通知**/
let leftViewBtnClickNotificatioin = "leftViewBtnClickNotificatioin"
/*左侧视图上部按钮点击通知**/
let leftViewTopBtnclickNotification = "leftViewTopBtnclickNotification"

//MARK:网络接口
//let ServerIP = "http://localhost:8080"
let ServerIP = "http://115.159.37.41:8080"
//服务器项目名称
let ServerName = "sshkuaishou"
//视频,图片 路径前缀
let VideoPrePath = ServerIP + "/" + ServerName + "/"

/***注册接口*/
let RegistIP = ServerIP + "/sshkuaishou/regist"
/***登录接口*/
let LoginIP = ServerIP + "/sshkuaishou/login"
/**上传视频*/
let UploadVideoIP = ServerIP + "/sshkuaishou/video_upload"

//MARK:首页接口
/**每页条数*/
let PageSize: Int = 20
/**获取关注视频接口**/
let HomeGuanZhuIP = ServerIP + "/sshkuaishou/video_getVideosOfUserGuanZhu"
/**获取发现视频接口**/
let HomeFaXianIP = ServerIP + "/sshkuaishou/video_pubVideo"
/**获取同城视频接口**/
let HomeTongChengIP = ServerIP + "/sshkuaishou/video_pubVideo"
/**添加关注接口**/
let AddGuanZhuIP = ServerIP + "/sshkuaishou/user_addGuanZhuUser"
/**添加双击接口**/
let AddLikeIP = ServerIP + "/sshkuaishou/video_addLike"

//MARK:我接口
/**添加双击接口**/
let PersonVideosIP = ServerIP + "/sshkuaishou/video_getVideosOfUser"












