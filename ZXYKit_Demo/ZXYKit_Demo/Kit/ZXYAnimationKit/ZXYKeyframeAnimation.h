//
//  ZXYKeyframeAnimation.h
//  CoreAnimate
//
//  Created by 赵翔宇 on 16/4/21.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface ZXYKeyframeAnimation : CAKeyframeAnimation

@property (nonatomic, weak, readonly) CALayer *layer;

@property(nonatomic, strong) id fromValue;
@property(nonatomic, strong) id toValue;
//@property(nullable, strong) id byValue;




- ( instancetype)initWithLayer:(CALayer *)layer KeyPath:(NSString *)keyPath;
@end
