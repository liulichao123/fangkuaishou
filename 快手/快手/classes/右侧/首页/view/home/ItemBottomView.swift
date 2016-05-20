//
//  ItemBottomView.swift
//  快手
//
//  Created by liulichao on 16/5/17.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class ItemBottomView: UIView {

    let likeLabel: UILabel
    let iconImageView: UIImageView
    
    override init(frame: CGRect) {
        
        iconImageView = UIImageView(frame: CGRectMake(5, -10, 20, 20))
        likeLabel = UILabel(frame: CGRectMake(frame.size.width - 50, 0, 50, frame.size.height))
        super.init(frame: frame)
        
        addSubview(iconImageView)
        addSubview(likeLabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
