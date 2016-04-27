//
//  ZXYPageView.h
//  Shop
//
//  Created by 赵翔宇 on 16/4/8.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ScrollDirectionHorizontal,
    ScrollDirectionVertical,
} ScrollDirection;

@class ZXYPageView;

@protocol ZXYPageViewDelegate <NSObject>

@optional
/**
 *  Called after the user changes the currentPage.
 *
 *  @param pageView    当前pageView
 *  @param currentPage 当前页数
 */
- (void)ZXYPageView:(ZXYPageView *)pageView currentPage:(NSInteger)currentPage;
/**
 *  Called after the user Click the currentPage.
 *
 *  @param pageView    当前pageView
 *  @param currentPage 当前页数
 */
- (void)ZXYPageView:(ZXYPageView *)pageView didClickAtCurrentPage:(NSInteger)currentPage;


@end

@protocol ZXYPageViewDataSource <NSObject>

@optional
/**
 *  Called when the user prefer show pageControl.
 *
 *  @param pageView pageView
 *
 *  @return YES Or NO
 */
- (BOOL)ZXYPageViewPreferShowPageControl:(ZXYPageView *)pageView;

@end

@interface ZXYPageView : UIView

/** 图片数组 */
@property (nonatomic, strong) NSArray<UIImage*> *images;
/** 文字数组,必须与图片数组数量相同 */
@property (nonatomic, strong) NSArray<NSString *> *titles;

/** 滚动方向 */
@property (nonatomic) ScrollDirection scrollDirection;
/** 滚动间隔时间 间隔不设置或设置为0 均不轮播*/
@property (nonatomic, assign) NSTimeInterval interval;
/** 滚动视图大小，默认为父视图大小 */
@property(nonatomic) CGRect            contentViewFrame;
/** 代理 */
@property (nonatomic, weak) id<ZXYPageViewDelegate> delegate;
/** 数据代理 */
@property (nonatomic, weak) id<ZXYPageViewDataSource> dataSource;


+ (instancetype)pageView;
+ (instancetype)pageViewWithImages:(NSArray<UIImage*> *) images;
- (instancetype)initWithImages:(NSArray<UIImage*> *) images;

@end
