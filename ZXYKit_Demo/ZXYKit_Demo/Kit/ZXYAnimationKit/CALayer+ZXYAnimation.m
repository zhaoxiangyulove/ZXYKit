//
//  CALayer+ZXYAnimation.m
//  CoreAnimate
//
//  Created by 赵翔宇 on 16/4/21.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "CALayer+ZXYAnimation.h"
#import "ZXYAnimationMaker.h"


@implementation CALayer (ZXYAnimation)

- (void)makeAnimations:(void (^)(ZXYAnimationMaker *))block{
    ZXYAnimationMaker *animationMaker = [[ZXYAnimationMaker alloc] initWithLayer:self];
    block(animationMaker);
    [animationMaker install];
}

@end
