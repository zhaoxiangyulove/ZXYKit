//
//  ZXYGraphModel.h
//  test
//
//  Created by 赵翔宇 on 16/4/18.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYGraphModel : NSObject
/** 数据 */
@property (nonatomic, assign) float value;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 颜色 */
@property (nonatomic, strong) UIColor *color;

/** 百分比 */
@property (nonatomic, assign) float percent;

+ (instancetype)modelWithValue:(float)value color:(UIColor *)color  title:(NSString *)title;

@end
