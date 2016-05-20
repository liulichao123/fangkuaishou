//
//  CommonNavView.swift
//  快手
//
//  Created by liulichao on 16/5/14.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
private let margin: CGFloat = 10
private let buttonW: CGFloat = 50
private let buttonH: CGFloat = 20
class CommonNavView: UIView {
    
    let leftBtn: UIButton
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        let x: CGFloat = margin
        let y: CGFloat = margin
        //左侧按钮
        leftBtn = UIButton(frame: CGRectMake(x, y, 30, 30))
        leftBtn.setImage(UIImage.init(named: "leftBtn_bd"), forState: UIControlState.Normal)
        leftBtn.setImage(UIImage.init(named: "leftBtn_bd_hl"), forState: UIControlState.Highlighted)
        leftBtn.layer.cornerRadius = 3
        leftBtn.layer.masksToBounds = true
        super.init(frame: frame)
        addSubview(leftBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
