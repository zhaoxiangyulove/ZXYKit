//
//  ZXYClipView.m
//  test
//
//  Created by 赵翔宇 on 16/4/19.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYClipView.h"
#define clipBorder  250
#define screenH  [UIScreen mainScreen].bounds.size.height
#define screenW  [UIScreen mainScreen].bounds.size.width
#define leftMargin (screenW - 250) * 0.5
#define topMargin (screenH - 250) * 0.5
#define rightMargin screenW * 0.5 + clipBorder*0.5
#define bottomMargin screenH *0.5 + clipBorder*0.5

@interface ZXYClipView ()
/**  */
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ZXYClipView

+ (instancetype)clipView{
    return [[self alloc] init];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


#pragma mark - 手势

- (void)pan:(UIPanGestureRecognizer *)pan{
    // 获取手势的移动，也是相对于最开始的位置
    CGPoint transP = [pan translationInView:self];
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, transP.x, transP.y);
    // 复位
    [pan setTranslation:CGPointZero inView:_imageView];
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self updateFrame];
    }
    
}
- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    _imageView.transform = CGAffineTransformScale(_imageView.transform, pinch.scale, pinch.scale);
    // 复位
    if (pinch.state == UIGestureRecognizerStateEnded) {
        [self updateFrame];
    }
    pinch.scale = 1;
}
- (void)updateFrame{
    CGRect frame = _imageView.frame;
    if (frame.size.width < clipBorder) {
        CGFloat scaleX = clipBorder / frame.size.width;
        frame.size.width = clipBorder;
        frame.size.height = frame.size.height * scaleX;
    }
    if (frame.size.height < clipBorder) {
        CGFloat scaleY = clipBorder / frame.size.height;
        frame.size.height = clipBorder;
        frame.size.width = frame.size.width * scaleY;
    }
    if (CGRectGetMinX(frame) > leftMargin) frame.origin.x = leftMargin;
    if (CGRectGetMaxX(frame) < rightMargin) frame.origin.x = rightMargin - frame.size.width;
    if (CGRectGetMinY(frame) > topMargin) frame.origin.y = topMargin;
    if (CGRectGetMaxY(frame) < bottomMargin) frame.origin.y = bottomMargin - frame.size.height;
    //获取偏移量，缩放比率
    _offX = frame.origin.x;
    _offY = frame.origin.y;
    _scaleRate = _image.size.width / frame.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        _imageView.frame = frame;
    }];
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
    _scaleRate = MIN(image.size.width/screenW, image.size.height/screenH);
    self.imageView.frame = CGRectMake(0, 0, image.size.width/_scaleRate, image.size.height/_scaleRate);
}

- (void)setRadiusRate:(CGFloat)radiusRate{
    _radiusRate = radiusRate;
    //绘制路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(leftMargin, topMargin, clipBorder, clipBorder) cornerRadius:_radiusRate * clipBorder * 0.5];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(screenW, 0)];
    [path addLineToPoint:CGPointMake(screenW, screenH)];
    [path addLineToPoint:CGPointMake(0, screenH)];
    [path addLineToPoint:CGPointMake(0, 0)];
    path.usesEvenOddFillRule = YES;
    
    //填充
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor= [UIColor blackColor].CGColor;    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    shapeLayer.opacity = 0.8;
    [self.layer addSublayer:shapeLayer];
    [self setToolBar];
    
}
- (void)setToolBar{
    //backBtn
    UIButton *backBtn = [self buttonWithName:@"Cancel" frame:CGRectMake(25, bottomMargin + 30, 80, 40)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    //chooseBtn
    UIButton *chooseBtn = [self buttonWithName:@"Choose" frame:CGRectMake(screenW - 105, bottomMargin +30, 80, 40)];
    [chooseBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chooseBtn];
}
- (UIButton *)buttonWithName:(NSString *)name frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    btn.frame = frame;
    return btn;
}
- (void)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:nil];
}
- (void)clicked{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseImage" object:nil];
}
- (UIImageView *)imageView {
    if(_imageView == nil) {
        UIImageView *iv = [[UIImageView alloc] init];
        iv.userInteractionEnabled = YES;
        [iv addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
        [iv addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)]];
        [self insertSubview:iv atIndex:0];
        _imageView = iv;
    }
    return _imageView;
}
@end
