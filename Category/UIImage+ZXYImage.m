//
//  UIImage+ZXYImage.m
//  test
//
//  Created by 赵翔宇 on 16/4/19.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//
#define screenH  [UIScreen mainScreen].bounds.size.height
#define screenW  [UIScreen mainScreen].bounds.size.width

#import "UIImage+ZXYImage.h"

@implementation UIImage (ZXYImage)

@end
@implementation UIImage (ZXYCircleImage)
+ (UIImage *)imageWithClipImageName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color cornerRadius:(CGFloat)radius{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image clipImageWithBorderWidth:borderWidth borderColor:color cornerRadius:radius];
    }
- (UIImage *)clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color cornerRadius:(CGFloat)radius{
    // 获取图片宽度
    CGFloat imageBorder = self.size.width<self.size.height?self.size.width:self.size.height;
    // 设置环的宽度
    
    CGFloat border = borderWidth;
    // 底层宽度和高度
    CGFloat backBorder = imageBorder + 2 * border;
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(backBorder, backBorder), NO, 0);
    // 画边
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, backBorder, backBorder) cornerRadius:radius* 0.5 * imageBorder];
    [color set];
    [path fill];
    // 设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(border, border, imageBorder, imageBorder) cornerRadius:radius* 0.5 * imageBorder];
    [clipPath addClip];
    // 绘制图片
    [self drawAtPoint:CGPointMake(border, border)];
    // 获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return clipImage;
}
- (UIImage *)clipImageWithFrame:(CGRect)frame scale:(CGFloat)scale{

    //算出截图的实际size
    
    CGRect factFrame = CGRectMake(frame.origin.x * scale, frame.origin.y *scale, frame.size.width * scale, frame.size.height * scale);
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, factFrame);
    UIGraphicsBeginImageContext(factFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, CGRectMake(0, 0, frame.size.width, frame.size.height), subImageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return image;
}
- (CGRect)frameToFit{
    CGFloat scale = MIN(self.size.width/screenW, self.size.height/screenH);
    return  CGRectMake(0, 0, self.size.width/scale, self.size.height/scale);
    
}
@end