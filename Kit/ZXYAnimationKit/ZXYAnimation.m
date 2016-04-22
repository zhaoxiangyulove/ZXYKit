//
//  ZXYAnimation.m
//  CoreAnimate
//
//  Created by 赵翔宇 on 16/4/21.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYAnimation.h"
#import "ZXYKeyframeAnimation.h"


@implementation ZXYAnimation

- (instancetype)initWithlayerAttribute:(ZXYKeyframeAnimation *)layerAttribute
{
    self = [super init];
    if (self) {
        _layerAttribute = layerAttribute;
    }
    return self;
}

- (ZXYAnimation * (^)(id attr))from{
    return ^id(id attribute) {
        _layerAttribute.fromValue = attribute;
        return self;
    };
}
- (ZXYAnimation *(^)(id))to{
    return ^id(id attribute) {
        _layerAttribute.toValue = attribute;
        return self;
    };
    
}
-(ZXYAnimation *(^)(id))values{
    return ^id(id attribute) {
        _layerAttribute.values = attribute;
        return self;
    };
}
@end
