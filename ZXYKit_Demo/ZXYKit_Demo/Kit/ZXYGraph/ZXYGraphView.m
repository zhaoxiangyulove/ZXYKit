//
//  ZXYGraphView.m
//  test
//
//  Created by 赵翔宇 on 16/4/18.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYGraphView.h"
#import "ZXYGraphModel.h"

@interface ZXYGraphView ()
{
    float total;
}
@end


@implementation ZXYGraphView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)removeSublayers{
    NSInteger count = self.layer.sublayers.count;
    for (int i = 0; i < count; i++) {
        CALayer *layer =self.layer.sublayers[0];
        [layer removeFromSuperlayer];
    }
}

- (void)drawPieRect:(CGRect)rect{
    [self removeSublayers];
    CGFloat radius = rect.size.width<rect.size.height?rect.size.width * 0.25 - 7:rect.size.height * 0.25 - 7;
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5 + 7);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:M_PI_2*3 endAngle:-M_PI_2 clockwise:NO];
    [self addShowPercentLayer:path lineWidth:radius *2];
    [self setTitlesWithFrame:CGRectMake(2, 2, 50, 200)];
    
}
- (void)drawBarRect:(CGRect)rect{
}




- (void)drawLineRect:(CGRect)rect{
}




-(void)addShowPercentLayer:(UIBezierPath *)path lineWidth:(CGFloat)lineWidth
{
    CGFloat startPer = 0;
    for (ZXYGraphModel *model in _values) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = model.color.CGColor;
        layer.strokeStart = startPer;
        model.percent = model.value / total;
        layer.strokeEnd = startPer + model.percent;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth = lineWidth;
        layer.shadowOffset = CGSizeMake(0, 1); //设置阴影的偏移量
        layer.shadowRadius = 1.0;  //设置阴影的半径
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOpacity = 0.8;
        [self.layer addSublayer:layer];
        startPer =layer.strokeEnd;
        [self percentAnimationEveryLayer:layer];
    }
    
}
/**
 *  添加动画
 *
 *  @param layer layer
 */
-(void)percentAnimationEveryLayer:(CAShapeLayer *)layer
{
    CABasicAnimation *strokeEndAnimation = nil;
    strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 1.0f;
    strokeEndAnimation.fromValue = @(layer.strokeStart);
    strokeEndAnimation.toValue = @(layer.strokeEnd);
    strokeEndAnimation.autoreverses = NO; //无自动动态倒退效果
    strokeEndAnimation.delegate = self;
    
    [layer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];
}

- (void)setTitlesWithFrame:(CGRect)frame{
    CATextLayer *layer = [CATextLayer layer];
    layer.frame = frame;
    layer.contentsScale = [UIScreen mainScreen].scale;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]init];
    NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
    for (ZXYGraphModel *model in _values) {
        textDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        textDic[NSForegroundColorAttributeName] = model.color;
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:model.title attributes:textDic];
        [string appendAttributedString:str];
        textDic[NSFontAttributeName] = [UIFont systemFontOfSize:6];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@":%.0lf%%\n",model.percent*100] attributes:textDic]];
    }
    layer.string = string;
    
    [self.layer addSublayer:layer];
    
}

/**
 *  随机生成颜色填充
 *
 *  @return 填充色
 */
- (UIColor *)colorRandom
{
    // 0 ~ 255 / 255
    // OC:0 ~ 1
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
#pragma mark - setValues
-(void)setValues:(NSArray<ZXYGraphModel *> *)values{
    _values = values;
    total = 0;
    for (int i = 0; i < values.count; i++) {
        total += values[i].value;
    }
    if(!CGRectIsEmpty(self.bounds)){
        switch (self.type) {
            case ZXYGraphViewPie:
                [self drawPieRect:self.bounds];
                break;
            case ZXYGraphViewBar:
                [self drawBarRect:self.bounds];
                break;
            case ZXYGraphViewLine:
                [self drawPieRect:self.bounds];
                break;
            default:
                break;
        }
    }
}


@end
