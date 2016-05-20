//
//  PersonHeaderView.swift
//  快手
//
//  Created by liulichao on 16/5/17.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class PersonHeaderView: UICollectionReusableView {
    var imageView: UIImageView?
    var iconView: UIImageView?
    var editPerson: UIButton?
    var fensi: UIButton?
    var guanzhu: UIButton?
    var jianjie: UIButton?
    var zuopin: UIButton?
    var like: UIButton?
    var buju: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        let screenW = ScreenSize.width
        var y : CGFloat = 0
        var x = y
        //顶部背景
        imageView = UIImageView(frame: CGRectMake(x, y, screenW, 200))
        imageView?.backgroundColor = UIColor.grayColor()
        imageView?.image = UIImage(named: "gougou.jpg")
        addSubview(imageView!)
        //头像
        y = (imageView?.frame.maxY)! - 20
        x = 10
        iconView = UIImageView(frame: CGRectMake(x, y, 80, 80))
        iconView?.backgroundColor = UIColor.blueColor()
        iconView?.image = UIImage(named: "xiaohuangren.jpg")
        iconView?.layer.masksToBounds = true
        iconView?.layer.cornerRadius = 40
        addSubview(iconView!)
        //编辑
        x = (iconView?.frame.maxX)! + 20
        y = (imageView?.frame.maxY)! + 10
        editPerson = UIButton(type: UIButtonType.Custom)
        editPerson?.frame = CGRectMake(x, y, 170, 20)
        editPerson?.backgroundColor = UIColor.orangeColor()
        editPerson?.setTitle("编辑个人信息", forState: UIControlState.Normal)
        editPerson?.titleLabel?.font = UIFont.systemFontOfSize(13)
        editPerson?.layer.borderWidth = 1
        editPerson?.layer.borderColor = UIColor.grayColor().CGColor
        addSubview(editPerson!)
        
        //粉丝
        y = (editPerson?.frame.maxY)! + 10
        fensi = UIButton(type: UIButtonType.Custom)
        fensi?.frame = CGRectMake(x, y, 80, 20)
        fensi?.setTitle("粉丝：0", forState: UIControlState.Normal)
        fensi?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        fensi?.backgroundColor = UIColor.purpleColor()
        addSubview(fensi!)
        
        //关注
        x = (fensi?.frame.maxX)! + 20
        guanzhu = UIButton(type: UIButtonType.Custom)
        guanzhu?.frame = CGRectMake(x, y, 80, 20)
        guanzhu?.setTitle("关注：0", forState: UIControlState.Normal)
        guanzhu?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        guanzhu?.backgroundColor = UIColor.greenColor()
        addSubview(guanzhu!)
        //简介
        x = 0
        y = (iconView?.frame.maxY)!
        jianjie = UIButton(type: UIButtonType.Custom)
        jianjie?.frame = CGRectMake(x, y, screenW, 30)
        jianjie?.setTitle("简介", forState: UIControlState.Normal)
        jianjie?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        jianjie?.backgroundColor = UIColor.greenColor()
        jianjie?.titleLabel?.textAlignment = NSTextAlignment.Left
        jianjie?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        jianjie?.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        addSubview(jianjie!)
        //作品
        y = (jianjie?.frame.maxY)!
        let w: CGFloat = (screenW - 30) * 0.5
        zuopin = UIButton(type: UIButtonType.Custom)
        zuopin?.frame = CGRectMake(x, y, w, 30)
        zuopin?.setTitle("作品", forState: UIControlState.Normal)
//        zuopin?.backgroundColor = UIColor.greenColor()
        zuopin?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        zuopin?.layer.borderWidth = 1
        addSubview(zuopin!)
        
        //喜欢
        x = (zuopin?.frame.maxX)!
        like = UIButton(type: UIButtonType.Custom)
        like?.frame = CGRectMake(x, y, w, 30)
        like?.setTitle("喜欢", forState: UIControlState.Normal)
        like?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        like?.backgroundColor = UIColor.greenColor()
        like?.layer.borderWidth = 1
        addSubview(like!)
        
        //布局
        x = (like?.frame.maxX)!
        buju = UIButton(type: UIButtonType.Custom)
        buju?.frame = CGRectMake(x, y, 30, 30)
        buju?.setTitle("排", forState: UIControlState.Normal)
        buju?.backgroundColor = UIColor.greenColor()
        buju?.layer.borderWidth = 1
        addSubview(buju!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
