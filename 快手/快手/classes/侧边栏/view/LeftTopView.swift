//
//  LeftTopView.swift
//  快手
//
//  Created by liulichao on 16/5/3.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
/**遮盖的高*/
private let coverH: CGFloat = 130
/**八卦按钮的宽高*/
private let w: CGFloat = 50
private let h: CGFloat = 70

class LeftTopView: UIView {

    var imageView: UIImageView
    var nickNameLabel: UILabel
    
    override init(frame: CGRect) {
        
        //头像
        let imageHW: CGFloat = 70
        let imageX: CGFloat = (frame.width - imageHW) / 2
        let imageY: CGFloat = (coverH - imageHW) / 2
        imageView = UIImageView(frame: CGRectMake(imageX, imageY, imageHW, imageHW))
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
//        imageView.backgroundColor = UIColor.redColor()
        //昵称
        nickNameLabel = UILabel(frame: CGRectMake(imageX, imageView.frame.maxY, imageHW, 20))
        nickNameLabel.text = "小明"
        nickNameLabel.font = UIFont.systemFontOfSize(13)
        nickNameLabel.textAlignment = NSTextAlignment.Center
        super.init(frame: frame)
        //添加底部横线
        let bottomLayer2 = CALayer()
        bottomLayer2.borderWidth = 2
        bottomLayer2.borderColor = UIColor.whiteColor().CGColor
        bottomLayer2.frame = CGRectMake(0, layer.frame.height - 1, frame.width, 1)
        layer.addSublayer(bottomLayer2)
        
        
        addSubview(imageView)
        addSubview(nickNameLabel)
        
        imageView.image = UIImage(named: "icon.jpeg")
        //头像遮罩
        let cover = UIButton(frame: CGRectMake(0, 0, frame.width, coverH))
        cover.tag = 0
        cover.addTarget(self, action: #selector(LeftTopView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(cover)
        
       
        
        let margin: CGFloat = (frame.width - 3 * w) / 4
        var x: CGFloat = margin
        let y = cover.frame.maxY
        
        //八卦
        let bagua = UIButton(frame: CGRectMake(x, y, w, h))
        bagua.setTitle("八卦", forState: UIControlState.Normal)
        bagua.setImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        bagua.titleLabel?.font = UIFont.systemFontOfSize(13)
        bagua.layoutButtonWithEdgeInsetsStyle(MKButtonEdgeInsetsStyle.Top, imageTitleSpace: 1)
        bagua.imageView?.layer.cornerRadius = 25
        bagua.imageView?.layer.masksToBounds = true
        bagua.addTarget(self, action: #selector(LeftTopView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        bagua.tag = 1
        addSubview(bagua)
        //消息
        x = x + w + margin
        let xiaoxi = UIButton(frame: CGRectMake(x, y, w, h))
        xiaoxi.setTitle("消息", forState: UIControlState.Normal)
        xiaoxi.setImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        xiaoxi.titleLabel?.font = UIFont.systemFontOfSize(13)
        xiaoxi.layoutButtonWithEdgeInsetsStyle(MKButtonEdgeInsetsStyle.Top, imageTitleSpace: 1)
        xiaoxi.imageView?.layer.cornerRadius = 25
        xiaoxi.imageView?.layer.masksToBounds = true
        xiaoxi.addTarget(self, action: #selector(LeftTopView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        xiaoxi.tag = 2
        addSubview(xiaoxi)
        //私信
        x = x + w + margin
        let sixin = UIButton(frame: CGRectMake(x, y, w, h))
        sixin.setTitle("私信", forState: UIControlState.Normal)
        sixin.setImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        sixin.titleLabel?.font = UIFont.systemFontOfSize(13)
        sixin.layoutButtonWithEdgeInsetsStyle(MKButtonEdgeInsetsStyle.Top, imageTitleSpace: 1)
        sixin.imageView?.layer.cornerRadius = 25
        sixin.imageView?.layer.masksToBounds = true
        sixin.addTarget(self, action: #selector(LeftTopView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        sixin.tag = 3
        addSubview(sixin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnClick(btn: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName(leftViewTopBtnclickNotification, object: nil, userInfo: ["type": btn.tag])
    }

}
