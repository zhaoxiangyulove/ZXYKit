//
//  ZXYStateBarHUD.h
//  ZXYStateBarHUD
//
//  Created by 赵翔宇 on 16/5/13.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYStateBarHUD : NSObject

/** 背景颜色 */
+ (void)setBackgroundColor:(UIColor *)backColor;
/**
 * 显示带图片普通信息
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image;
/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg;
/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg;
/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg;
/**
 * 显示警告信息
 */
+ (void)showWarning:(NSString *)msg;
/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg;
/**
 * 隐藏
 */
+ (void)hide;
@end
