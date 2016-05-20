//
//  RootViewController.swift
//  快手
//
//  Created by liulichao on 16/5/3.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    /**侧边栏状态 false:关闭 true:开启*/
    var leftState:Bool = false
    /**首页遮盖 用于显示左侧时，遮盖右侧*/
    lazy var rightCover: UIButton = {
        let button: UIButton = UIButton(frame: CGRectMake(self.leftVc.view.frame.width,statusBarSize.height, self.view.frame.width, self.view.frame.height))
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: #selector(RootViewController.leftBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    /**右侧视图*/
    let rightVC: RightViewController = RightViewController()
    
    /**左侧视图*/
    lazy var leftVc: LeftViewController = {
        return LeftViewController()
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        //右侧视图
        rightVC.view.frame = view.frame
        addChildViewController(rightVC)
        view.addSubview(rightVC.view)

        //添加监听通知
        //左上角按钮通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RootViewController.leftBtnClick), name: leftBtnClickNotificatioin, object: nil)
        //左侧按钮点击通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RootViewController.leftViewBtnClick(_:)), name: leftViewBtnClickNotificatioin, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 通知监听方法
    //左上角按钮点击
    func leftBtnClick() {
        if leftState {//隐藏
            //移除遮盖
            rightCover.removeFromSuperview()
            
            UIView.animateWithDuration(0.3, animations: { 
                var contentFrame = self.rightVC.view.frame
                contentFrame.origin.x = contentFrame.origin.x - 200
                self.rightVC.view.frame = contentFrame
                
                var leftFrame = self.leftVc.view.frame
                leftFrame.origin.x = leftFrame.origin.x - 200
                self.leftVc.view.frame = leftFrame
            }, completion: { (hasComp) in
                //移除左侧视图
                self.leftVc.view.removeFromSuperview()
            })
        }else{//出现
            //添加遮盖
            view.addSubview(rightCover)
            //添加右侧视图
            view.insertSubview(leftVc.view, atIndex: 0)
            UIView.animateWithDuration(0.3, animations: { 
                var contentFrame = self.rightVC.view.frame
                contentFrame.origin.x = contentFrame.origin.x + 200
                self.rightVC.view.frame = contentFrame
                
                var leftFrame = self.leftVc.view.frame
                leftFrame.origin.x = leftFrame.origin.x + 200
                self.leftVc.view.frame = leftFrame
                
            })
        }
        leftState = !leftState
    }
    //左侧按钮点击
    func leftViewBtnClick(notification: NSNotification) {
        //移动视图
        leftBtnClick()
        
        let userInfo = notification.userInfo
        let type: Int = (userInfo!["type"]?.integerValue)!
        switch type {
        case 0:
            print("左侧按钮点击头像")
            rightVC.currentType = RightType.Person
        case 1:
            print("左侧按钮点击八卦")
        case 2:
            print("左侧按钮点击消息")
        case 3:
            print("左侧按钮点击私信")
        case 4:
            print("左侧按钮点击首页")
            rightVC.currentType = RightType.Home
        case 5:
            print("左侧按钮点击发现")
        case 6:
            print("左侧按钮点击本地作品")
        case 7:
            print("左侧按钮点击设置")
            rightVC.currentType = RightType.Setting
            
        default:
            print("左侧按钮点击默认")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
