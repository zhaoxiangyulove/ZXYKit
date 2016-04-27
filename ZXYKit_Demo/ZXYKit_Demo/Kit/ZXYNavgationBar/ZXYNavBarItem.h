//
//  ZXYNavBarItem.h
//  ZXYNavgationBar
//
//  Created by 赵翔宇 on 16/4/27.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYNavBarItem : UIButton
/** 比例值 */
@property (nonatomic, assign) CGFloat scale;
/** to Color */
@property (nonatomic, weak) UIColor *selectedColor;
@end
