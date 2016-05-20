//
//  LeftViewController.swift
//  快手
//
//  Created by liulichao on 16/5/4.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

enum LeftViewBtnType: String{
    case  HomeBtnType
    case  FaxianBtnType
}


class LeftViewController: UIViewController {
    var topView: UIView!
    var home: UIButton!
    var find: UIButton!
    var local: UIButton!
    var setting: UIButton!
    var backgroudImage:UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化
        setup()
   
//        NSNotificationCenter.defaultCenter().postNotificationName("11", object: nil, userInfo: ["type" : (LeftViewBtnType.FaxianBtnType,"ad")])
        //左侧上部按钮点击通知监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LeftViewController.topBtnClick(_:)), name: leftViewTopBtnclickNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        let screenFrame = UIScreen.mainScreen().bounds
        let frame = CGRectMake(-200, statusBarSize.height, 200, screenFrame.height)
        view.frame = frame
        var y: CGFloat = 0
        //背景
        backgroudImage = UIImageView(frame: CGRectMake(0, y, frame.width, frame.height))
        let image = UIImage(named: "login_bg_cover")
        backgroudImage.image = image
        
        topView = LeftTopView(frame: CGRectMake(0, y, frame.width, 200))
        y = y + topView.frame.height
        
        
        home = LeftButton(frame: CGRectMake(0, y, frame.width, 50))
        home.setTitle("首页", forState: UIControlState.Normal)
        home.tag = 1
        y = y + home.frame.height
        
        
        find = LeftButton(frame: CGRectMake(0, y, frame.width, 50))
        find.setTitle("查找", forState: UIControlState.Normal)
        find.tag = 2
        y = y + find.frame.height
        
        local = LeftButton(frame: CGRectMake(0, y, frame.width, 50))
        local.setTitle("本地作品", forState: UIControlState.Normal)
        local.tag = 3
        y = y + local.frame.height
        
        setting = LeftButton(frame:  CGRectMake(0, y, frame.width, 50))
        local.setTitle("设置", forState: UIControlState.Normal)
        local.tag = 4
        
        view.addSubview(backgroudImage)
        view.addSubview(topView)
        view.addSubview(home)
        view.addSubview(find)
        view.addSubview(local)
        
        home.addTarget(self, action: #selector(LeftViewController.btnclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        find.addTarget(self, action: #selector(LeftViewController.btnclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        local.addTarget(self, action: #selector(LeftViewController.btnclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        setting.addTarget(self, action: #selector(LeftViewController.btnclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    //按钮点击监听(1-3 转化为 4-7)
    func btnclick(btn: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName(leftViewBtnClickNotificatioin, object: nil, userInfo: ["type":btn.tag + 3])
        
        home.selected = false
        find.selected = false
        local.selected = false
        setting.selected = false
        btn.selected = true
    }
    //topView按钮点击通知(0-3)
    func topBtnClick(notificatioin: NSNotification) {
        let userInfo = notificatioin.userInfo
        let type = userInfo!["type"]!.integerValue
               NSNotificationCenter.defaultCenter().postNotificationName(leftViewBtnClickNotificatioin, object: nil, userInfo: ["type":type])
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
