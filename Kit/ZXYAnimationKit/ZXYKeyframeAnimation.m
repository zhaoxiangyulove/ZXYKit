//
//  ZXYKeyframeAnimation.m
//  CoreAnimate
//
//  Created by 赵翔宇 on 16/4/21.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYKeyframeAnimation.h"
#import "ZXYUtilities.h"

@implementation ZXYKeyframeAnimation

+ (instancetype)keyFrameAnimation{
    return [[self alloc] init];
}

- (instancetype)initWithLayer:(CALayer *)layer KeyPath:(NSString *)keyPath
{
    self = [super init];
    if (self) {
        _layer = layer;
        self.keyPath = keyPath;
        [self setupFromValue];
        
    }
    return self;
}

- (void)setupFromValue{
    if ([self.keyPath isEqualToString:@"position"]) {
        self.fromValue = ZXYBoxValue(_layer.position);
    }else if ([self.keyPath isEqualToString:@"transform.scale"]){
        self.fromValue = ZXYBoxValue(1);
    }else if ([self.keyPath isEqualToString:@"transform.rotation"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"transform.rotation.x"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"transform.rotation.y"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"transform.rotation.z"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"transform.translation"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"transform.translation.x"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"transform.translation.y"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"transform.translation.z"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"backgroundColor"]){
        self.fromValue = ZXYBoxValue(_layer.backgroundColor);
    }else if ([self.keyPath isEqualToString:@"bounds"]){
        self.fromValue = ZXYBoxValue(_layer.bounds);
    }else if ([self.keyPath isEqualToString:@"sublayerTransform.scale"]){
        self.fromValue = ZXYBoxValue(1);
    }else if ([self.keyPath isEqualToString:@"sublayerTransform.rotation"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"sublayerTransform.translation"]){
        self.fromValue = ZXYBoxValue(0);
    }else if ([self.keyPath isEqualToString:@"cornerRadius"]){
        self.fromValue = ZXYBoxValue(_layer.cornerRadius);
    }else if ([self.keyPath isEqualToString:@"borderWidth"]){
        self.fromValue = ZXYBoxValue(_layer.borderWidth);
    }else if ([self.keyPath isEqualToString:@"borderColor"]){
        self.fromValue = ZXYBoxValue(_layer.borderColor);
    }else if ([self.keyPath isEqualToString:@"opacity"]){
        self.fromValue = ZXYBoxValue(_layer.opacity);
    }else if ([self.keyPath isEqualToString:@"strokeEnd"]){
        self.fromValue = ZXYBoxValue(0);
    }
}
- (void)setFromValue:(id)fromValue{
    _fromValue = fromValue;
    if (self.values.count != 0) {
        NSMutableArray *array = [self.values mutableCopy];
        [array replaceObjectAtIndex:0 withObject:fromValue];
        self.values = array;
    }else{
        self.values = @[fromValue];
    }
}
- (void)setToValue:(id)toValue{
    _toValue = toValue;
    NSMutableArray *array = [self.values mutableCopy];
    [array addObject:toValue];
    self.values = array;
    
}
@end
