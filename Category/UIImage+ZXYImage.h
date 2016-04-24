//
//  UIImage+ZXYImage.h
//  test
//
//  Created by 赵翔宇 on 16/4/19.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZXYImage)

+ (instancetype)imageNamed:(NSString *)name renderMode:(UIImageRenderingMode)render;

@end
@interface UIImage (ZXYCircleImage)
+ (instancetype)imageWithClipImageName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;
- (instancetype)clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;
- (instancetype)clipImageWithFrame:(CGRect)frame scale:(CGFloat)scale;
- (CGRect)frameToFit;
@end