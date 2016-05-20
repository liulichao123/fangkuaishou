//
//  HomeDetailNavBar.swift
//  快手
//
//  Created by liulichao on 16/5/15.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
/**首页详情导航栏代理*/
@objc
protocol HomeDetailNavBarDelegate {
/**首页详情导航栏代理，index: 从左至右 1-6*/
func homeDetailNavBarDelegate(index: Int)
}
class HomeDetailNavBar: UINavigationBar {
    //代理一定要用weak 否则会造成控制器不能销毁
    /**首页详情导航栏代理*/
   weak var detailDelegate: HomeDetailNavBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let item = UINavigationItem()
        let barBtn1 = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeDetailNavBar.click(_:)))
        let barBtn2 = UIBarButtonItem(title: "关注", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeDetailNavBar.click(_:)))
        let barBtn3 = UIBarButtonItem(title: "双击", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeDetailNavBar.click(_:)))
        let barBtn4 = UIBarButtonItem(title: "举报", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeDetailNavBar.click(_:)))
        let barBtn5 = UIBarButtonItem(title: "分享", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeDetailNavBar.click(_:)))
        let barBtn6 = UIBarButtonItem(title: "头像", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeDetailNavBar.click(_:)))
        barBtn1.tag = 1
        barBtn2.tag = 2
        barBtn3.tag = 3
        barBtn4.tag = 4
        barBtn5.tag = 5
        barBtn6.tag = 6
        
        item.leftBarButtonItems = [barBtn1,barBtn2,barBtn3,barBtn4,barBtn5]
        item.rightBarButtonItem = barBtn6
        items = [item]
        lt_setBackgroundColor(UIColor.init(colorLiteralRed: 251.0 / 255, green: 199.0 / 255, blue: 75.0 / 255, alpha: 0.7))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**按钮点击*/
    func click(btn: UIBarButtonItem) {
        detailDelegate?.homeDetailNavBarDelegate(btn.tag)
    }
    /**隐藏第几个按钮 1- 5*/
    func hiddenBtnIndex(index: Int) {
//       items?.first?.leftBarButtonItems?.removeAtIndex(index)
    }
}
