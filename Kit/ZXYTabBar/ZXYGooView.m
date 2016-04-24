//
//  ZXYGooView.m
//  ZXYTabBar
//
//  Created by 赵翔宇 on 16/4/24.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//
#define kMaxDistance 60

#import "ZXYGooView.h"

@interface ZXYGooView ()
{
    CGFloat h;
}

@property (nonatomic, weak) CALayer  *smallCircleLayer;

@property (nonatomic, assign) CGFloat oriSmallRadius;

@property (nonatomic, weak) CAShapeLayer *shapeLayer;

@end

@implementation ZXYGooView

+ (instancetype)gooViewWithBadgeValue:(NSInteger)badgeValue{
    ZXYGooView *gooView = [[self alloc] init];
    gooView.badgeValue = badgeValue;
    return gooView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib{
    [self setUp];
}

- (void)setUp{
    
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:8];
    self.backgroundColor = [UIColor redColor];
    // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (h != self.bounds.size.height) {
        h = self.bounds.size.height;
        // 记录小圆最初始半径
        self.layer.cornerRadius = h / 2;
        self.smallCircleLayer.cornerRadius = h / 2;
    }
    
}


- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint transP = [pan translationInView:self];
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    self.center = center;
    [pan setTranslation:CGPointZero inView:self];
    
    
    
    
    CGFloat d = [self distanceFromBigCircleCenter:self.center smallCircleCenter:_smallCircleLayer.position];
    
    // 计算小圆的半径
    CGFloat smallRadius = _oriSmallRadius - d / 10;
    // 设置小圆的尺寸
    _smallCircleLayer.bounds = CGRectMake(0, 0, smallRadius * 2, smallRadius * 2);
    _smallCircleLayer.cornerRadius = smallRadius;
    
    // 描述不规则矩形
    if (d > kMaxDistance) {
        // 隐藏小圆,移除矩形
        _smallCircleLayer.hidden = YES;
        [_shapeLayer removeFromSuperlayer];
        _shapeLayer = nil;
    }else if(d > 0 && _smallCircleLayer.hidden == NO){ // 有圆心距离，并且圆心距离不大，才需要展示
        // 展示不规则矩形，通过不规则矩形路径生成一个图层
        
        self.shapeLayer.path = [self pathWithBigCirCleView:self smallCirCleLayer:_smallCircleLayer].CGPath;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        // 当圆心距离大于最大距离
        if (d > kMaxDistance) {
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformMakeScale(2, 2);
                self.alpha = 0;
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
                if ([_delegate respondsToSelector:@selector(gooViewRemove)]) {
                    [_delegate gooViewRemove];
                }
                
            });
            
        }else{
            // 移除不规则矩形
            [self.shapeLayer removeFromSuperlayer];
            self.shapeLayer = nil;
            
            // 还原位置
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                // 设置大圆中心点位置
                self.center = _smallCircleLayer.position;
            } completion:^(BOOL finished) {
                // 显示小圆
                _smallCircleLayer.hidden = NO;
            }];
        }
    }

 }

// 计算两个圆心之间的距离
- (CGFloat)distanceFromBigCircleCenter:(CGPoint)bigCircleCenter smallCircleCenter:(CGPoint)smallCircleCenter
{
    CGFloat offsetX = bigCircleCenter.x - smallCircleCenter.x;
    CGFloat offsetY = bigCircleCenter.y - smallCircleCenter.y;
    return  sqrt(offsetX * offsetX + offsetY * offsetY);
}

// 描述两圆之间一条矩形路径
- (UIBezierPath *)pathWithBigCirCleView:(UIView *)bigCirCleView  smallCirCleLayer:(CALayer *)smallCirCleLayer
{
    
    CGPoint bigCenter = bigCirCleView.center;
    CGFloat x2 = bigCenter.x;
    CGFloat y2 = bigCenter.y;
    CGFloat r2 = bigCirCleView.bounds.size.height / 2;
    
    CGPoint smallCenter = smallCirCleLayer.position;
    CGFloat x1 = smallCenter.x;
    CGFloat y1 = smallCenter.y;
    CGFloat r1 = smallCirCleLayer.bounds.size.height / 2;
    
    
    
    // 获取圆心距离
    CGFloat d = [self distanceFromBigCircleCenter:bigCenter smallCircleCenter:smallCenter];
    CGFloat sinθ = (x2 - x1) / d;
    CGFloat cosθ = (y2 - y1) / d;
    // 坐标系基于父控件
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ , y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ , y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ , y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ , y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d / 2 * sinθ , pointA.y + d / 2 * cosθ);
    CGPoint pointP =  CGPointMake(pointB.x + d / 2 * sinθ , pointB.y + d / 2 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // A
    [path moveToPoint:pointA];
    // AB
    [path addLineToPoint:pointB];
    // 绘制BC曲线
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    // CD
    [path addLineToPoint:pointD];
    // 绘制DA曲线
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setBadgeValue:(NSInteger)badgeValue{
    _badgeValue = badgeValue;
    
    NSString *title = badgeValue > 99 ?@"99+" : [NSString stringWithFormat:@"%ld",badgeValue] ;
    [self setTitle:title forState:UIControlStateNormal];
//    self.smallCircleLayer.hidden = NO;
    
}

#pragma mark -  懒加载
- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        _shapeLayer = layer;
        layer.fillColor = self.backgroundColor.CGColor;
        [self.superview.layer insertSublayer:layer below:self.layer];
    }
    return _shapeLayer;
    
}
- (CALayer *)smallCircleLayer{
    if (_smallCircleLayer == nil) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = self.backgroundColor.CGColor;
        _oriSmallRadius = self.bounds.size.height / 2;
        _smallCircleLayer = layer;
        _smallCircleLayer.anchorPoint = CGPointMake(0.5, 0.5);
        _smallCircleLayer.position = self.center;
        _smallCircleLayer.bounds = self.bounds;
        [self.superview.layer insertSublayer:layer below:self.layer];
        
    }
    return _smallCircleLayer;
}
@end
