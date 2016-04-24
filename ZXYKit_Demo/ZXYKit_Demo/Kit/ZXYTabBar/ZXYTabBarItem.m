//
//  ZXYTabBarItem.m
//  ZXYTabBar
//
//  Created by 赵翔宇 on 16/4/23.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYTabBarItem.h"
#import "ZXYGooView.h"

@interface ZXYTabBarItem ()<ZXYGooViewDelegate>

/** 标记 */
@property (nonatomic, weak) ZXYGooView *gooView;

@end

@implementation ZXYTabBarItem
- (void)awakeFromNib
{
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    if (CGRectEqualToRect(CGRectZero, _gooView.frame)) {
        CGFloat width = frame.size.width > 60 ?frame.size.width : 60;
        _gooView.frame = CGRectMake(frame.size.width * 0.65, 3, width / 4, 15);
    }
    if (self.titleLabel.text.length != 0) {
        self.imageView.frame = CGRectMake(2, 2, frame.size.width -4, frame.size.height * 0.8-2);
        self.titleLabel.frame =CGRectMake(2, frame.size.height * 0.8, frame.size.width -4, frame.size.height * 0.2-2);
    }
}

+ (instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    ZXYTabBarItem *item = [self buttonWithType:UIButtonTypeCustom];
    [item setImage:image selectedImage:selectedImage];
    return item;
}
- (void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
//    [self setTitle:title forState:UIControlStateHighlighted];
//    [self setTitle:title forState:UIControlStateSelected];
}
- (void)setImage:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:selectedImage forState:UIControlStateHighlighted];
    [self setImage:selectedImage forState:UIControlStateSelected];
}



- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self setTitleColor:textColor forState:UIControlStateNormal];
}
- (void)setSelectedTextColor:(UIColor *)selectedTextColor{
    _selectedTextColor = selectedTextColor;
    [self setTitleColor:selectedTextColor forState:UIControlStateHighlighted];
    [self setTitleColor:selectedTextColor forState:UIControlStateSelected];
}


- (UIColor *)backColor {
    if(_backColor == nil) {
        _backColor = [UIColor clearColor];
    }
    return _backColor;
}


- (void)setBadgeValue:(NSInteger)badgeValue{
    _badgeValue = badgeValue;
    if (badgeValue != 0) {
        self.gooView.hidden = NO;
    }
}



- (ZXYGooView *)gooView {
	if(_gooView == nil) {
		ZXYGooView *gooView = [ZXYGooView gooViewWithBadgeValue:_badgeValue];
        gooView.delegate = self;
        [self addSubview:gooView];
        _gooView = gooView;
        
        
	}
	return _gooView;
}

-(void)gooViewRemove{
    if ([_delegate respondsToSelector:@selector(tabBarItemGooViewRemove:)]) {
        _gooView = nil;
        [_delegate tabBarItemGooViewRemove:self];
        
    }
    
}

@end
