//
//  ZXYNavBarView.h
//  ZXYNavgationBar
//
//  Created by 赵翔宇 on 16/4/27.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXYNavBarView;

@protocol  ZXYNavBarViewDelegate<NSObject>
@optional
- (NSString *)navBarView:(ZXYNavBarView *)navBarView titleAtIndex:(NSInteger)index;
- (void)navBarView:(ZXYNavBarView *)navBarView didScrollAtIndexPath:(NSInteger)index;

@end

typedef enum : NSUInteger {
    ShowDirectionHorizontal,
    ShowDirectionVertical,
} ShowDirectionType;

@interface ZXYNavBarView : UIView
/** 展示方向 */
@property (nonatomic, assign) ShowDirectionType type;
/** 代理 */
@property (nonatomic, weak) UIViewController<ZXYNavBarViewDelegate>  *delegate;
/** title color */
@property (nonatomic, strong) UIColor *titleColor;
/** selected Color */
@property (nonatomic, strong) UIColor *selectedColor;
/** back Color */
@property (nonatomic, strong) UIColor *backColor;


+ (instancetype)navBarView;
+ (instancetype)navBarViewWithType:(ShowDirectionType)type;

@end
