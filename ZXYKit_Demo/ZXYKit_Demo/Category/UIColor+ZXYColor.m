//
//  UIColor+ZXYColor.m
//  test
//
//  Created by 赵翔宇 on 16/4/18.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "UIColor+ZXYColor.h"

@implementation UIColor (ZXYColor)

+ (UIColor *)colorRandom
{
    // 0 ~ 255 / 255
    // OC:0 ~ 1
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
