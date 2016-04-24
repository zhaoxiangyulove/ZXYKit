//
//  UIView+ZXYView.h
//  Category
//
//  Created by 赵翔宇 on 16/4/23.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZXYView)

@end
@interface UIView (Frame)
// @property如果在分类里面只会生成get,set方法的声明，并不会生成成员属性。
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@end