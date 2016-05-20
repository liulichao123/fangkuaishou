//
//  ViewController.swift
//  快手
//
//  Created by liulichao on 16/5/4.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var superView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: UIButtonType.System)
        btn.frame = CGRectMake(-50, 0, 100, 100)
        btn.backgroundColor = UIColor.redColor()
        superView.addSubview(btn)
        btn.addTarget(self, action: #selector(ViewController.onclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onclick(btn: UIButton) {
        print("打印")
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
