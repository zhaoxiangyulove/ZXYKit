//
//  ZXYStateBarHUD.m
//  ZXYStateBarHUD
//
//  Created by 赵翔宇 on 16/5/13.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYStateBarHUD.h"

#define ZXYMessageFont [UIFont systemFontOfSize:12]
#define ZXYScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation ZXYStateBarHUD
/** HUD高度 */
static CGFloat const windowH = 20;
/** 停留时间 */
static CGFloat const messageDuration = 2.0;
/** 动画时间 */
static CGFloat const animationDuration = 0.25;

/** 窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;
/** 背景色 */
static UIColor *backColor_;

+ (void)setBackgroundColor:(UIColor *)backColor{
    backColor_ = backColor;
}

/**
 * 显示窗口
 */
+ (void)setupWindow
{
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = backColor_? backColor_: [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = CGRectMake(0, - windowH, ZXYScreenWidth, windowH);
}

/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    //隐藏上次的窗口
    window_.hidden = YES;

    // 创建窗口
    [self setupWindow];
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:msg forState:UIControlStateNormal];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    button.titleLabel.font = ZXYMessageFont;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.frame = window_.bounds;
    [window_ addSubview:button];
    
    window_.hidden = NO;
    
    // 动画
    CGRect frame = window_.frame;
    frame.origin.y = 0;
    [UIView animateWithDuration:animationDuration animations:^{
        window_.frame = frame;
    }];
    
}

/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg{
    if (timer_) [timer_ invalidate];
    [self showMessage:msg image:nil];
    timer_ = [NSTimer scheduledTimerWithTimeInterval:messageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg
{
    if (timer_) [timer_ invalidate];
    [self showMessage:msg image:[UIImage imageNamed:@"ZXYStateBarHUD.bundle/OK"]];
    timer_ = [NSTimer scheduledTimerWithTimeInterval:messageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg{
    if (timer_) [timer_ invalidate];
    [self showMessage:msg image:[UIImage imageNamed:@"ZXYStateBarHUD.bundle/error"]];
    timer_ = [NSTimer scheduledTimerWithTimeInterval:messageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}
/**
 * 显示警告信息
 */
+ (void)showWarning:(NSString *)msg{
    if (timer_) [timer_ invalidate];
    [self showMessage:msg image:[UIImage imageNamed:@"ZXYStateBarHUD.bundle/warning"]];
    timer_ = [NSTimer scheduledTimerWithTimeInterval:messageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg{
    // 停止定时器
    if (timer_) {
        [timer_ invalidate];
        timer_ = nil;
    }
    //隐藏上次的窗口
    window_.hidden = YES;
    // 显示窗口
    [self setupWindow];
    
    // 添加圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    loadingView.frame = CGRectMake(0, 0, 20, 20);
    [loadingView startAnimating];
    [window_ addSubview:loadingView];
    // 添加文字
    UILabel *label = [[UILabel alloc] init];
    label.font = ZXYMessageFont;
    label.frame = CGRectMake(20, 0, window_.frame.size.width - 20, 20);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    [window_ addSubview:label];
}

/**
 * 隐藏
 */
+ (void)hide
{
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y =  - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}



@end
