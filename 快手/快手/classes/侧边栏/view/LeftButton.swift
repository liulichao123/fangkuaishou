//
//  LeftButton.swift
//  快手
//
//  Created by liulichao on 16/5/3.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class LeftButton: UIButton {

    override init(frame: CGRect) {

        super.init(frame: frame)
        let bottomLayer2 = CALayer()
        bottomLayer2.borderWidth = 2
        bottomLayer2.borderColor = UIColor.whiteColor().CGColor
        bottomLayer2.frame = CGRectMake(0, layer.frame.height - 1, frame.width, 1)
        layer.addSublayer(bottomLayer2)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        let image = UIImage(named: "btnbc")
        setBackgroundImage(image, forState: UIControlState.Selected)
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
