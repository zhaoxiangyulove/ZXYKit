//
//  ZXYGooView.h
//  ZXYTabBar
//
//  Created by 赵翔宇 on 16/4/24.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXYGooViewDelegate <NSObject>

- (void)gooViewRemove;

@end

@interface ZXYGooView : UIButton

/** badgeValue */
@property (nonatomic, assign) NSInteger badgeValue;
/** 代理 */
@property (nonatomic, weak) id<ZXYGooViewDelegate> delegate;
/** 字体 */
@property (nonatomic, strong) UIFont *titleFont;

+ (instancetype)gooViewWithBadgeValue:(NSInteger)badgeValue;


@end
