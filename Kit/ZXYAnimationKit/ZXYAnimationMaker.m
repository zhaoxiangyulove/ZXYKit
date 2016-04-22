//
//  ZXYAnimationMaker.m
//  CoreAnimate
//
//  Created by 赵翔宇 on 16/4/21.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYAnimationMaker.h"
#import "ZXYKeyframeAnimation.h"
#import "ZXYAnimation.h"

@interface ZXYAnimationMaker ()<ZXYAnimationDelegate>
{
    float counts;
    float time;
    BOOL reverses;
    
}

/** 原始layer */
@property (nonatomic, weak) CALayer *layer;
/** 动画数组 */
@property (nonatomic, strong) NSMutableArray *animations;

@end

@implementation ZXYAnimationMaker

- (instancetype)initWithLayer:(CALayer *)layer
{
    self = [super init];
    if (self) {
        self.layer = layer;
        self.animations = [NSMutableArray new];
        _superlayer = layer.superlayer;
        time = 1;
        counts = 1;
        reverses = NO;
    }
    return self;
}

- (ZXYAnimation *)position{
    return [self addBasicAnimationWithKeyPath:@"position"];
}
- (ZXYAnimation *)scale{
    return [self addBasicAnimationWithKeyPath:@"transform.scale"];
}
- (ZXYAnimation *)rotation{
    return [self addBasicAnimationWithKeyPath:@"transform.rotation"];
}
- (ZXYAnimation *)rotationX{
    return [self addBasicAnimationWithKeyPath:@"transform.rotation.x"];
}
- (ZXYAnimation *)rotationY{
    return [self addBasicAnimationWithKeyPath:@"transform.rotation.y"];
}
- (ZXYAnimation *)rotationZ{
    return [self addBasicAnimationWithKeyPath:@"transform.rotation.z"];
}
- (ZXYAnimation *)translation{
    return [self addBasicAnimationWithKeyPath:@"transform.translation"];
}
- (ZXYAnimation *)translationX{
    return [self addBasicAnimationWithKeyPath:@"transform.translation.x"];
}
- (ZXYAnimation *)translationY{
    return [self addBasicAnimationWithKeyPath:@"transform.translation.y"];
}
- (ZXYAnimation *)translationZ{
    return [self addBasicAnimationWithKeyPath:@"transform.translation.z"];
}
- (ZXYAnimation *)backcolor{
    return [self addBasicAnimationWithKeyPath:@"backgroundColor"];
}
- (ZXYAnimation *)bounds{
    return [self addBasicAnimationWithKeyPath:@"bounds"];
}
//- (ZXYAnimation *)hidden{
//    return [self addBasicAnimationWithKeyPath:@"hidden"];
//}
- (ZXYAnimation *)submakeScale{
    return [self addBasicAnimationWithKeyPath:@"sublayerTransform.scale"];
}
- (ZXYAnimation *)submakeRotation{
    return [self addBasicAnimationWithKeyPath:@"sublayerTransform.rotation"];
}
- (ZXYAnimation *)submaketranslation{
    return [self addBasicAnimationWithKeyPath:@"sublayerTransform.translation"];
}
- (ZXYAnimation *)cornerRadius{
    return [self addBasicAnimationWithKeyPath:@"cornerRadius"];
}
- (ZXYAnimation *)borderWidth{
    return [self addBasicAnimationWithKeyPath:@"borderWidth"];
}
- (ZXYAnimation *)borderColor{
    return [self addBasicAnimationWithKeyPath:@"borderColor"];
}
- (ZXYAnimation *)opacity{
    return [self addBasicAnimationWithKeyPath:@"opacity"];
}

- (ZXYAnimation *)addBasicAnimationWithKeyPath:(NSString *)keyPath {
    ZXYKeyframeAnimation *layerAttribute = [[ZXYKeyframeAnimation alloc] initWithLayer:self.layer KeyPath:keyPath];
    ZXYAnimation *newAnimation = [[ZXYAnimation alloc] initWithlayerAttribute:layerAttribute];
    newAnimation.delegate = self;
    [self.animations addObject: newAnimation.layerAttribute];

    return newAnimation;
}

-(ZXYAnimationMaker *(^)(float))repeatCount{
    return  ^id(float count) {
        counts = count;
        return self;
    };
}
-(ZXYAnimationMaker *(^)(float))duration{
    return  ^id(float duration) {
        time = duration;
        return self;
    };
}
- (ZXYAnimationMaker *(^)(BOOL))autoreverses{
    return  ^id(BOOL autoreverses) {
        reverses = autoreverses;
        return self;
    };
}

- (void)install {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = self.animations;
    group.repeatCount = counts;
    // 设置动画完成的时候不要移除动画
    group.removedOnCompletion = NO;
    // 设置动画执行完成要保持最新的效果
    group.fillMode = kCAFillModeForwards;
    group.autoreverses = reverses;
    group.duration = time;
    NSLog(@"%@",self.layer);
    [self.layer addAnimation:group forKey:nil];
}

@end
