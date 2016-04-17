//
//  ZXYMenuView.m
//  test
//
//  Created by 赵翔宇 on 16/4/17.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYMenuView.h"

@implementation ZXYMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    // left
    UIView *leftV = [[UIView alloc] init];
    [self addSubview:leftV];
    _leftView = leftV;
    // right
    UIView *rightV = [[UIView alloc] init];
    [self addSubview:rightV];
    _rightView = rightV;
    // main
    UIView *mainV = [[UIView alloc] init];
    [self addSubview:mainV];
    _mainView = mainV;
}
- (void)layoutSubviews{
    CGFloat alpha = ABS(_mainView.frame.origin.x) / (self.bounds.size.width * 2) + 0.7;
    CGFloat scaleX = ABS(_mainView.frame.origin.x) / (self.bounds.size.width * 12) + 0.95;
    CGFloat scaleY = ABS(_mainView.frame.origin.x) / (self.bounds.size.width * 20) + 0.97;
    if (_mainView.frame.origin.x > 0) { // 往右边移动，隐藏蓝色的view
        _rightView.hidden = YES;
        _leftView.hidden = NO;
        _leftView.alpha = alpha;
        _leftView.transform = CGAffineTransformMakeScale(scaleX, scaleY);
    }else if (_mainView.frame.origin.x < 0){ // 往左边移动，显示蓝色的view
        _rightView.hidden = NO;
        _leftView.hidden = YES;
        _rightView.alpha = alpha;
        _rightView.transform = CGAffineTransformMakeScale(scaleX, scaleY);
    }
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _mainView.frame = frame;
    _leftView.frame = frame;
    _rightView.frame = frame;
}

@end
