//
//  AppDelegate.swift
//  快手
//
//  Created by liulichao on 16/5/3.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        swichController()
        window?.makeKeyAndVisible()
        

        return true
    }

    func swichController() {
//        let object = NSUserDefaults.standardUserDefaults().objectForKey("userDict")
       let phone = NSUserDefaults.standardUserDefaults().stringForKey(UserPhoneKey)
        if phone != nil{
            printLog("已有账号。。。。")
            self.window?.rootViewController = RootViewController()
            //设置单例
            let user = UserTool.sharedInstance.user
            user.password = NSUserDefaults.standardUserDefaults().stringForKey(UserPwdKey)
            user.id = NSUserDefaults.standardUserDefaults().integerForKey(UserIdKey)
            user.phone = phone
            printLog(user.id)
            let params = ["phone" : phone!, "password" : user.password!]
            //此处应该用代理或者通知回调 来通知appDelegate 是否登录成功
            Alamofire.request(.GET, LoginIP, parameters: params)
                    .responseJSON { response in
                        if let JSON: NSDictionary = response.result.value as? NSDictionary{
                            //print("JSON: \(JSON)")
                            let status = JSON.objectForKey("status")?.intValue
                            if status == 200{
                                printLog("登录成功")
                                //更新用户数据
//                                let userJson = JSON.objectForKey("user")!
//                                let userDict: NSMutableDictionary = NSMutableDictionary()

                            }else{
                                printLog("登录失败")
                                self.window?.rootViewController = LoginViewController()
                                self.window?.makeKeyAndVisible()
                            }
                        }else{
                            printLog("登录失败")
                            self.window?.rootViewController = LoginViewController()
                            self.window?.makeKeyAndVisible()
                        }
            }
        }else{
            printLog("没有检测到账号。。。。")
            self.window?.rootViewController = LoginViewController()
        }
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//        Modeltool.distoryCache(<#T##models: [HomeVideo]##[HomeVideo]#>)
    }


}

