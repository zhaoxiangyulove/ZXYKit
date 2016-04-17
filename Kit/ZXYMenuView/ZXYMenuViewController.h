//
//  ZXYMenuViewController.h
//  test
//
//  Created by 赵翔宇 on 16/4/17.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYMenuViewController : UIViewController
/** 主视图控制器 */
@property (nonatomic, weak) UIViewController *mainVC;
/** 左视图控制器 */
@property (nonatomic, weak) UIViewController *leftVC;
/** 右视图控制器 */
@property (nonatomic, weak) UIViewController *rightVC;
/** 背景颜色 */
@property (nonatomic, weak) UIColor *backColor;

@end
