//
//  ZXYTabBar.m
//  ZXYTabBar
//
//  Created by 赵翔宇 on 16/4/23.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYTabBar.h"


@interface ZXYTabBar ()<ZXYTabBarItemDelegate>
{
    CGFloat remainderWidth;
    int customItemCount;
}

@property (nonatomic, weak) ZXYTabBarItem *selectedItem;
//@property (nonatomic, strong) NSArray<UITabBarItem*> *items;
/** 选中layer */
@property (nonatomic, weak) CALayer *selectLayer;
@end


@implementation ZXYTabBar
@synthesize items = _items;

#pragma mark - 实例声明
+ (instancetype)tabBarWithDelegate:(UITabBarController<ZXYTabBarDelegate> *)delegate{
    ZXYTabBar *tabBar = [[self alloc] init];
    tabBar.delegate = delegate;
    return tabBar;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        remainderWidth = [UIScreen mainScreen].bounds.size.width;
        customItemCount = 0;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark - 布局

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_delegate.tabBar.subviews.count > 1) {
        for (UIView *childView in _delegate.tabBar.subviews) {
            if (![childView isKindOfClass:[ZXYTabBar class]]) {
                [childView removeFromSuperview];
            }
        }
    }
    
    NSUInteger count = self.items.count;

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = remainderWidth / (count - customItemCount);
    CGFloat h = self.frame.size.height;
    
    ZXYTabBarItem *lastItem = nil;
    for (int i = 0; i < count; i++) {
        ZXYTabBarItem *item = self.subviews[i];
        
        x = CGRectGetMaxX(lastItem.frame);
        if (CGSizeEqualToSize(CGSizeZero, item.size)) {
            item.frame = CGRectMake(x, y, w, h);
        }else{
            item.frame = CGRectMake(x, h - item.size.height, item.size.width, item.size.height);
        }
        lastItem = item;
    }
    if (_selectLayer)_selectLayer.frame = self.selectedItem.frame;
}
#pragma mark - ZXYTabBarItemDelegate

-(void)tabBarItemGooViewRemove:(ZXYTabBarItem *)item{
    if ([_delegate respondsToSelector:@selector(tabBar:didRomveItemGooView:)]) {
        [_delegate tabBar:self didRomveItemGooView:item];
    }
}

- (NSArray *)items {
    if(_items == nil) {
        NSMutableArray *itemArray = [NSMutableArray array];
        for (UIViewController *vc in _delegate.childViewControllers) {
            [itemArray addObject: vc.tabBarItem];
        }
        
        self.items = itemArray;
    }
    return _items;
}



- (void)setItems:(NSArray<UITabBarItem *> *)items{
    BOOL preferSize =[_delegate respondsToSelector:@selector(tabBar:sizeForItemAtIndex:)];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < items.count; i++) {
        ZXYTabBarItem *item = [ZXYTabBarItem itemWithImage:items[i].image selectedImage:items[i].selectedImage];
        [array addObject:item];
        item.backgroundColor = item.backColor;
        item.delegate = self;
        item.tag = i;
        [item setTitle:items[i].title];
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
        if (preferSize) {
            item.size = [_delegate tabBar:self sizeForItemAtIndex:item.tag];
            if (!CGSizeEqualToSize(CGSizeZero, item.size)) {
                remainderWidth -= item.size.width;
                if (remainderWidth < 0) {
                    NSException *e = [NSException
                                      exceptionWithName: @"异常情况："
                                      reason: @"items总宽度大于屏幕宽度"
                                      userInfo: nil];
                    @throw e;
                }
                customItemCount++;
            }
        }
        if (item.tag == _selectedIndex) {
            [self itemClick:item];
        }
        [self addSubview:item];
    }
    _items = array;
}
- (void)itemClick:(ZXYTabBarItem *)item{
    _selectedItem.selected = NO;
    _selectedItem.backgroundColor = _selectedItem.backColor;
    if (_selectLayer) {
        [UIView animateWithDuration:0.25 animations:^{
            _selectLayer.frame = item.frame;
            _selectLayer.transform = CATransform3DMakeScale(0.3, 0.3, 0.3);
        } completion:^(BOOL finished) {
            _selectLayer.transform = CATransform3DIdentity;
        }];
    }

    item.selected = YES;
    
    _selectedItem = item;
 

    // 代理切换控制器
    _delegate.selectedIndex = item.tag;
    if ([_delegate respondsToSelector:@selector(tabBar:didClickItem:)]) {
        [_delegate tabBar:self didClickItem:_selectedItem];
    }
    
}

- (void)setDelegate:(UITabBarController<ZXYTabBarDelegate> *)delegate{
    _delegate = delegate;
    self.frame = delegate.tabBar.bounds;
    [_delegate.tabBar addSubview: self];
}

- (void)setSelectedBackColor:(UIColor *)selectedBackColor{
    _selectedBackColor = selectedBackColor;
    CALayer *layer = [[CALayer alloc] init];
    [self.layer insertSublayer:layer atIndex:0];
    _selectLayer = layer;
    _selectLayer.backgroundColor = selectedBackColor.CGColor;
}
@end
