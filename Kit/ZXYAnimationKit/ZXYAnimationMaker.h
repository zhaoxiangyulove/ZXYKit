//
//  ZXYAnimationMaker.h
//  CoreAnimate
//
//  Created by 赵翔宇 on 16/4/21.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CALayer;
@class ZXYAnimation;

@interface ZXYAnimationMaker : NSObject



@property (nonatomic, strong, readonly) ZXYAnimation *position;
@property (nonatomic, strong, readonly) ZXYAnimation *scale;
@property (nonatomic, strong, readonly) ZXYAnimation *scaleX;
@property (nonatomic, strong, readonly) ZXYAnimation *scaleY;
@property (nonatomic, strong, readonly) ZXYAnimation *rotation;
@property (nonatomic, strong, readonly) ZXYAnimation *rotationX;
@property (nonatomic, strong, readonly) ZXYAnimation *rotationY;
@property (nonatomic, strong, readonly) ZXYAnimation *rotationZ;
@property (nonatomic, strong, readonly) ZXYAnimation *translation;
@property (nonatomic, strong, readonly) ZXYAnimation *translationX;
@property (nonatomic, strong, readonly) ZXYAnimation *translationY;
@property (nonatomic, strong, readonly) ZXYAnimation *translationZ;
@property (nonatomic, strong, readonly) ZXYAnimation *backcolor;
@property (nonatomic, strong, readonly) ZXYAnimation *bounds;
//@property (nonatomic, strong, readonly) ZXYAnimation *hidden;
@property (nonatomic, weak, readonly) CALayer *superlayer;
@property (nonatomic, strong, readonly) ZXYAnimation *submakeScale;
@property (nonatomic, strong, readonly) ZXYAnimation *submakeRotation;
@property (nonatomic, strong, readonly) ZXYAnimation *submaketranslation;
@property (nonatomic, strong, readonly) ZXYAnimation *cornerRadius;
@property (nonatomic, strong, readonly) ZXYAnimation *borderWidth;
@property (nonatomic, strong, readonly) ZXYAnimation *borderColor;
@property (nonatomic, strong, readonly) ZXYAnimation *opacity;

- (ZXYAnimationMaker * (^)(float count))repeatCount;
- (ZXYAnimationMaker * (^)(float duration))duration;
- (ZXYAnimationMaker * (^)(BOOL autoreverses))autoreverses;
- (instancetype)initWithLayer:(CALayer *)layer;
- (void)install;
@end
