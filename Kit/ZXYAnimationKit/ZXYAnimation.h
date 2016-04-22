//
//  ZXYAnimation.h
//  CoreAnimate
//
//  Created by 赵翔宇 on 16/4/21.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYUtilities.h"

#define from(...)                 from(ZXYBoxValue((__VA_ARGS__)))
#define to(...)                 to(ZXYBoxValue((__VA_ARGS__)))
@class ZXYKeyframeAnimation;

@protocol ZXYAnimationDelegate <NSObject>



@end

@interface ZXYAnimation : NSObject

@property (nonatomic, strong, readonly) ZXYKeyframeAnimation *layerAttribute;

//代理
@property (nonatomic, weak) id<ZXYAnimationDelegate> delegate;

- (id)initWithlayerAttribute:(ZXYKeyframeAnimation *)layerAttribute;

- (ZXYAnimation * (^)(id attr))from;
- (ZXYAnimation * (^)(id attr))to;
- (ZXYAnimation * (^)(id attr))values;

@end
