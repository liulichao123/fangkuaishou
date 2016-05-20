//
//  NavSliderView.swift
//  快手
//
//  Created by liulichao on 16/5/4.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class NavSliderView: UIView {
    private var slider: UIView
    private var count: Int
    private var perW: CGFloat
    /**
     导航栏滑动视图
     - parameter frame: 滑动视图frame
     - parameter count: 滑动块个数
     */
    init(frame: CGRect, count: Int) {
        perW = frame.width / CGFloat(count)
        slider = UIView(frame: CGRectMake(0, 0, perW, frame.height))
        slider.backgroundColor = UIColor.redColor()
        self.count = count
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        slider.layer.cornerRadius = 3
        addSubview(slider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**移动到下标位置（不带动画 1-count）*/
    internal func moveToIndex(index: Int) {
        /**下标从1开始**/
        let x = perW * CGFloat(index-1)
        self.slider.frame.origin.x = x
    }
    /**移动到下标位置（带动画 1- count）*/
    internal func moveToIndexWithAnimate(index: Int) {
        /**下标从1开始**/
        let x = perW * CGFloat(index-1)
        UIView.animateWithDuration(0.2) {
            self.slider.frame.origin.x = x
        }
    }
    /**
     根据传入比例移动slider
     - parameter scale: slider滑块位置 占sliderView宽度的比例
     */
    internal func moveToScale(scale: CGFloat){
        slider.frame.origin.x = scale * slider.frame.width * 2
    }
    
    
    
    
}


