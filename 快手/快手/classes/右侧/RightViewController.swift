//
//  RightViewController.swift
//  快手
//
//  Created by liulichao on 16/5/15.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
/**右侧显示控制器的类型**/
enum RightType: Int {
    case Person
    case BaGua
    case XiaoXi
    case SiXin
    case Home
    case ChaZhao
    case Setting
    case BenDi
}
/**需要根据设置的类型RightType显示内容*/
class RightViewController: UIViewController {
    
    //当前显示类型 设置后更新内容
    var currentType: RightType = RightType.Home {
        didSet {
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParentViewController()
            switch currentType {
            case RightType.Person:
                currentVC = personVc
            case RightType.Home:
                currentVC = homeVc
            case RightType.Setting:
                currentVC = settingVc
            default:
                currentVC = homeVc
                printLog("默认")
            }
            addChildViewController(currentVC)
            view.addSubview(currentVC.view)
        }
    }
    /**当前控制器*/
    lazy var currentVC: UIViewController = {
        //默认首页
        return self.homeVc
    }()
    /**个人*/
    lazy var personVc: PersonViewController = {
       let layout =  UICollectionViewFlowLayout()
        let w = (statusBarSize.width - 20) / 3
        let h = w + 10
        layout.itemSize = CGSizeMake(w, h)
        let personVc = PersonViewController(collectionViewLayout: layout)
        personVc.modelUser = UserTool.sharedInstance.user
        return personVc
    }()
    /**首页*/
    lazy var homeVc: HomeViewController = {
        return HomeViewController()
    }()
    /**设置*/
    lazy var settingVc: SettingViewController = {
        return SettingViewController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加默认
        addChildViewController(currentVC)
        view.addSubview(currentVC.view)
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
    deinit{
        printLog("销毁")
    }
}
