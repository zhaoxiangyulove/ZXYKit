//
//  ZXYTabBarItem.h
//  ZXYTabBar
//
//  Created by 赵翔宇 on 16/4/23.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXYTabBarItem;

@protocol ZXYTabBarItemDelegate <NSObject>

- (void)tabBarItemGooViewRemove:(ZXYTabBarItem *)item;

@end


@interface ZXYTabBarItem : UIButton

/** 默认颜色 */
@property (nonatomic, strong) UIColor *textColor;
/** 选中颜色 */
@property (nonatomic, strong) UIColor *selectedTextColor;
/** 默认背景颜色 */
@property (nonatomic, strong) UIColor *backColor;
/** 代理 */
@property (nonatomic, weak) id<ZXYTabBarItemDelegate> delegate;
/** BadgeValue */
@property (nonatomic, assign) NSInteger badgeValue;



/** 尺寸 */
@property (nonatomic, assign) CGSize size;



+ (instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage;
- (void)setTitle:(NSString *)title;
- (void)setImage:(UIImage *)image selectedImage:(UIImage *)selectedImage;




@end
