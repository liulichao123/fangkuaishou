//
//  LNavigationView.swift
//  快手
//
//  Created by liulichao on 16/5/3.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
private let margin: CGFloat = 10
private let buttonW: CGFloat = 50
private let buttonH: CGFloat = 20
/**导航栏代理**/
@objc protocol LNavigationDelegate{
    /**导航栏按钮点击*/
    func navButtonClick(button: UIButton)
}

class LNavigationView: UIView {
    /**内部按钮点击代理*/
    weak var delegate: LNavigationDelegate?
    
    
    private var left: UIButton
    
    private var guanzhu: UIButton
    private var faxian: UIButton
    private var tongcheng: UIButton
    
    private var luxiang: UIButton
    
    private var sliderView: NavSliderView

    /**必须使用该方法初始化*/
    override init(frame: CGRect) {
        var x: CGFloat = margin
        let y: CGFloat = margin
        //左侧按钮
        left = UIButton(frame: CGRectMake(x, 5, 30, 30))
        left.setImage(UIImage.init(named: "leftBtn_bd"), forState: UIControlState.Normal)
        left.setImage(UIImage.init(named: "leftBtn_bd_hl"), forState: UIControlState.Highlighted)
        left.layer.cornerRadius = 3
        left.layer.masksToBounds = true
        left.tag = 0
        //中间(提前计算好位置)
        let centerX = frame.width/2
        let sunmW = buttonW*3
        x = centerX - sunmW/2
        
        guanzhu = UIButton(frame: CGRectMake(x, y, buttonW, buttonH))
        guanzhu.setTitle("关注", forState: UIControlState.Normal)
        guanzhu.tag = 1

        x = x + buttonW
        faxian = UIButton(frame: CGRectMake(x, y, buttonW, buttonH))
        faxian.setTitle("发现", forState: UIControlState.Normal)
        faxian.tag = 2

        x = x + buttonW
        tongcheng = UIButton(frame: CGRectMake(x, y, buttonW, buttonH))
        tongcheng.setTitle("同城", forState: UIControlState.Normal)
        tongcheng.tag = 3

        //右侧
        x = frame.width - margin - buttonW
        luxiang = UIButton(frame: CGRectMake(x, y, buttonW, buttonH))
        luxiang.setTitle("上传", forState: UIControlState.Normal)
        luxiang.tag = 4
        
        //滑动视图
        sliderView = NavSliderView(frame: CGRectMake(guanzhu.frame.origin.x, guanzhu.frame.maxY + 2, sunmW, 5), count: 3)
        
        super.init(frame: frame)
        
        left.addTarget(self, action: #selector(LNavigationView.leftClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        guanzhu.addTarget(self, action: #selector(LNavigationView.guanzhuClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        faxian.addTarget(self, action: #selector(LNavigationView.faxianClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        tongcheng.addTarget(self, action: #selector(LNavigationView.tongchengClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        luxiang.addTarget(self, action: #selector(LNavigationView.luxiangClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        addSubview(left)
        addSubview(guanzhu)
        addSubview(faxian)
        addSubview(tongcheng)
        addSubview(luxiang)
        addSubview(sliderView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**导航栏滑动条滚动至index(1-count)**/
    internal func navBtnMoveToIndex(index: Int) {
        sliderView.moveToIndex(index)
    }
     /**导航栏滑动条滚动至index(1-count)带动画**/
    internal func navBtnMoveToIndexWithAnimate(index: Int) {
        sliderView.moveToIndexWithAnimate(index)
    }
    /**
     根据传入比例移动slider
     - parameter scale: slider滑块位置 占sliderView宽度的比例
     */
    internal func moveToScale(scale: CGFloat){
        sliderView.moveToScale(scale)
    }
    //MARK:按钮监听
    func leftClick( button: UIButton) {
       delegate?.navButtonClick(button)
        
    }

    func guanzhuClick( button: UIButton) {
        sliderView.moveToIndexWithAnimate(button.tag)
        delegate?.navButtonClick(button)
    }
    func faxianClick( button: UIButton) {
        sliderView.moveToIndexWithAnimate(button.tag)
        delegate?.navButtonClick(button)
    }
    func tongchengClick( button: UIButton) {
        sliderView.moveToIndexWithAnimate(button.tag)
        delegate?.navButtonClick(button)
        
    }
    func luxiangClick( button: UIButton) {
        delegate?.navButtonClick(button)
        
    }
}
