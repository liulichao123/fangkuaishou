//
//  SettingViewController1.swift
//  快手
//
//  Created by liulichao on 16/5/15.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏
        let navBar = UINavigationBar(frame: CGRectMake(0, 0, ScreenSize.width, 50))
        let item = UINavigationItem(title: "设置")
        item.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SettingViewController.back))
        navBar.items = [item]
        //使用分类方法修改navBar 背景颜色，因为直接修改颜色会被加蒙版
        navBar.lt_setBackgroundColor(UIColor.init(colorLiteralRed: 251.0 / 255, green: 199.0 / 255, blue: 75.0 / 255, alpha: 1))
        view.addSubview(navBar)
        //tableView
        let frame = CGRectMake(0, navBar.frame.maxY, view.frame.width, view.frame.height - navBar.frame.height)
        tableView = UITableView(frame: frame, style: UITableViewStyle.Grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.bounces = false
        tableView.shouldGroupAccessibilityChildren = true
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLineEtched
        view.addSubview(tableView)
        
    }
    func back() {
        printLog("返回")
        //发送通知告诉父控制器
        NSNotificationCenter.defaultCenter().postNotificationName(leftBtnClickNotificatioin, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        printLog(section)
        switch section {
        case 0:
            return 2
        case 1:
           return 1
        default:
            return 3
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.text = "清除缓存"
            }else{
                cell.textLabel?.text = "绑定手机"
            }
            

        case 1:
            cell.textLabel?.text = "退出"
        default: break
            
        }
        
        return cell
    }

    // MARK: - tableview
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let alertVc = UIAlertController(title: nil, message: "已为您清理快手缓存10M", preferredStyle: UIAlertControllerStyle.Alert)
                presentViewController(alertVc, animated: true, completion: { 
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0)), dispatch_get_main_queue(), {
                        alertVc.dismissViewControllerAnimated(true, completion:nil)
                    })
                })
            }else{
                let alertVc = UIAlertController(title: nil, message: "该功能待完善。。。", preferredStyle: UIAlertControllerStyle.Alert)
                presentViewController(alertVc, animated: true, completion: {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0)), dispatch_get_main_queue(), {
                        alertVc.dismissViewControllerAnimated(true, completion:nil)
                    })
                })
            }
            
        case 1://退出
            UIApplication.sharedApplication().keyWindow?.rootViewController = LoginViewController()
        default: break
        
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    deinit{
        printLog("销毁")
    }
}
