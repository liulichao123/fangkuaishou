//
//  KSCollectionLayout.swift
//  快手
//
//  Created by liulichao on 16/5/5.
//  Copyright © 2016年 刘立超. All rights reserved.
//


class KSCollectionLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
