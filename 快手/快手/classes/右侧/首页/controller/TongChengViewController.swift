//
//  TongChengViewController.swift
//  快手
//
//  Created by liulichao on 16/5/13.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class TongChengViewController: BaseViewController {

    //重写父类， 设置类型
    override func mytype() -> HomeType {
        return HomeType.TongCheng
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
