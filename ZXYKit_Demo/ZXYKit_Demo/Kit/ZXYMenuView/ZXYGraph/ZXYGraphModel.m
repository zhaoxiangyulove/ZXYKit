//
//  ZXYGraphModel.m
//  test
//
//  Created by 赵翔宇 on 16/4/18.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYGraphModel.h"

@implementation ZXYGraphModel
+ (instancetype)modelWithValue:(float)value color:(UIColor *)color title:(NSString *)title{
    return [[self alloc] initWithValue:value color:color title:title];
}

- (instancetype)initWithValue:(float)value color:(UIColor *)color title:(NSString *)title{
    self = [super init];
    if (self) {
        _value = value;
        _color = color;
        _title = title;
    }
    return self;
}
@end
