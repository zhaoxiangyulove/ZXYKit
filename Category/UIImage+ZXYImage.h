//
//  UIImage+ZXYImage.h
//  test
//
//  Created by 赵翔宇 on 16/4/19.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZXYImage)

@end
@interface UIImage (ZXYCircleImage)
+ (UIImage *)imageWithClipImageName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;
- (UIImage *)clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;
- (UIImage *)clipImageWithFrame:(CGRect)frame scale:(CGFloat)scale;
- (CGRect)frameToFit;
@end