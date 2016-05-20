//
//  FaxianViewController.swift
//  快手
//
//  Created by liulichao on 16/5/13.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class FaxianViewController: BaseViewController {
    
//    private let homeType: String = "nihao"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    //重写父类， 设置类型
    override func mytype() -> HomeType {
       return HomeType.FaXian
    }
//    //添加上拉刷新
//    func setupRefresh() {
//        collectionView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            
//        })
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
