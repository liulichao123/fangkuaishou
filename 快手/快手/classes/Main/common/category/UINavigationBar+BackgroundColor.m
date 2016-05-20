//
//  UINavigationBar+BackgroundColor.m
//  快手
//
//  Created by liulichao on 16/5/14.
//  Copyright © 2016年 刘立超. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>
@implementation UINavigationBar (BackgroundColor)
static char overlayKey;
- (UIView *)overlay{
    
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor{    if (!self.overlay) {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];        // insert an overlay into the view hierarchy
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height)];
    [self insertSubview:self.overlay atIndex:0];
}    self.overlay.backgroundColor = backgroundColor;
}
@end
