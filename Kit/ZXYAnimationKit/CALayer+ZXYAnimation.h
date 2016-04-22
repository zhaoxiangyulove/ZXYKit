//
//  CALayer+ZXYAnimation.h
//  CoreAnimate
//
//  Created by 赵翔宇 on 16/4/21.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class ZXYAnimationMaker;

@interface CALayer (ZXYAnimation)
- (void)makeAnimations:(void(^)(ZXYAnimationMaker *make))block;
@end
