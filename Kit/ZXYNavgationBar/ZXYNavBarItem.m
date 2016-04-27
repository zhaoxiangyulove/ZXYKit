//
//  ZXYNavBarItem.m
//  ZXYNavgationBar
//
//  Created by 赵翔宇 on 16/4/27.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYNavBarItem.h"

@interface ZXYNavBarItem ()
{
    CGFloat fromRed;
    CGFloat fromGreen;
    CGFloat fromBlue;
    CGFloat toRed;
    CGFloat toGreen;
    CGFloat toBlue;
}

@end

@implementation ZXYNavBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;

    CGFloat red = fromRed + (toRed - fromRed) * scale;
    CGFloat green = fromGreen + (toGreen - fromGreen) * scale;
    CGFloat blue = fromBlue + (toBlue - fromBlue) * scale;
    [self setTitleColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0] forState:UIControlStateNormal];
    
    CGFloat transformScale = 1 + scale * 0.2; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    [selectedColor getRed:&(toRed) green:&(toGreen) blue:&(toBlue) alpha:0];
    [self.titleLabel.textColor getRed:&(fromRed) green:&(fromGreen) blue:&(fromBlue) alpha:0];
}


@end
