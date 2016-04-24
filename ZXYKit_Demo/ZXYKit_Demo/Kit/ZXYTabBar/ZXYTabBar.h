//
//  ZXYTabBar.h
//  ZXYTabBar
//
//  Created by 赵翔宇 on 16/4/23.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYTabBarItem.h"
@class ZXYTabBar;

@protocol ZXYTabBarDelegate <NSObject>


@optional
- (void)tabBar:(ZXYTabBar *)tabBar didClickItem:(ZXYTabBarItem *)item;

- (void)tabBar:(ZXYTabBar *)tabBar didRomveItemGooView:(ZXYTabBarItem *)item;


- (CGSize)tabBar:(ZXYTabBar *)tabBar sizeForItemAtIndex:(NSInteger)index;



@end

@interface ZXYTabBar : UIView

/**
 *  ZXYTabBarItem
 */
@property (nonatomic, strong, readonly) NSArray<ZXYTabBarItem*> *items;
/** 初始选项，默认为1 */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 选中背景颜色 */
@property (nonatomic, strong) UIColor *selectedBackColor;
@property (nonatomic, weak) UITabBarController<ZXYTabBarDelegate> *delegate;

+ (instancetype)tabBarWithDelegate:(UITabBarController<ZXYTabBarDelegate> *)delegate;

@end
