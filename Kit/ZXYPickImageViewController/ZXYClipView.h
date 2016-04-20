//
//  ZXYClipView.h
//  test
//
//  Created by 赵翔宇 on 16/4/19.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYClipView : UIView


/** 图片 */
@property (nonatomic, weak) UIImage *image;

/** 圆角比例 0～1*/
@property (nonatomic, assign) CGFloat radiusRate;

@property (nonatomic, assign) CGFloat offX;
@property (nonatomic, assign) CGFloat offY;
@property (nonatomic, assign) CGFloat scaleRate;
+ (instancetype)clipView;



@end
