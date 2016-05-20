//
//  LoginViewController.swift
//  快手
//
//  Created by liulichao on 16/5/11.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!//手机号
    @IBOutlet weak var passWord: UITextField!//密码
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /**
     登录
     */
    @IBAction func loginClick(sender: AnyObject) {

            let params = ["phone" : self.userName.text!, "password" : self.passWord.text!]
            Alamofire.request(.GET, LoginIP, parameters: params)
                .responseJSON { response in
                    if let JSON: NSDictionary = response.result.value as? NSDictionary{
                        //                    print("JSON: \(JSON)")
                        let status = JSON.objectForKey("status")?.intValue
                        if status == 200{
                            printLog("登录成功")
                            
                            let userJson = JSON.objectForKey("user")!
                            //保存本地
                            let id: Int = userJson.objectForKey("id")!.integerValue
                            NSUserDefaults.standardUserDefaults().setValue(id, forKey: UserIdKey)
                            printLog(id)
                            NSUserDefaults.standardUserDefaults().setValue(self.userName.text, forKey: UserPhoneKey)
                            NSUserDefaults.standardUserDefaults().setValue(self.passWord.text, forKey: UserPwdKey)
                            NSUserDefaults.standardUserDefaults().synchronize()
                            //设置单例
                            let user = UserTool.sharedInstance.user
                            user.id = id
                            user.phone = self.userName.text
                            user.password = self.passWord.text
                            printLog(user.id)
                           
                            //切换窗口
                            UIApplication.sharedApplication().delegate?.window!!.rootViewController = RootViewController()
                            
                        }else{
                            printLog("登录失败")
                        }
                    }else{
                        printLog("登录失败")
                    }
        }
        
    }
    

    @IBAction func registClick(sender: AnyObject) {
        //蒙版
//        let alertVc = UIAlertController(title: "注册成功", message: "正在登录中。。。", preferredStyle: UIAlertControllerStyle.Alert)
        let params = ["phone" : userName.text!, "password" : passWord.text!]
        Alamofire.request(.GET, RegistIP, parameters: params)
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let status = JSON.objectForKey("status")?.intValue
                    if status == 200{
                        //注册成功直接登录
//                        self.presentViewController(alertVc, animated: true, completion: {
                            self.loginClick(NSNull)
//                        })
                        
                    }else if status == 1 {
                        let alertVc = UIAlertController(title: "注册成功", message: "正在登录中。。。", preferredStyle: UIAlertControllerStyle.Alert)
                        self.presentViewController(alertVc, animated: true, completion: {
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5)), dispatch_get_main_queue(), {
                                alertVc.dismissViewControllerAnimated(true, completion: nil)
                            })
                        })
                    }

                }else{
                    
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
