//
//  ZXYPickImageViewController.h
//  test
//
//  Created by 赵翔宇 on 16/4/19.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXYPickImageViewController;

@protocol ZXYPickImageViewControllerDelegate <NSObject>
- (void)pickImageViewController:(ZXYPickImageViewController *)picker didFinishPickingImage:(UIImage *)image;

@end

@interface ZXYPickImageViewController : UIImagePickerController

/** 圆角比例 0～1*/
@property (nonatomic, assign) CGFloat radiusRate;
/** 边框宽度 */
@property (nonatomic, assign) CGFloat border;
/** 边框颜色 */
@property (nonatomic, copy) UIColor *borderColor;
/** 代理 */
@property (nonatomic, weak) id<ZXYPickImageViewControllerDelegate> clipDelegate;

+ (instancetype)sharePickImageController;
@end
