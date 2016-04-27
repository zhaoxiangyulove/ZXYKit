//
//  ZXYNavBarView.m
//  ZXYNavgationBar
//
//  Created by 赵翔宇 on 16/4/27.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYNavBarView.h"
#import "ZXYNavBarItem.h"

@interface ZXYNavBarView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

@end

@implementation ZXYNavBarView
+ (instancetype)navBarView{
    ZXYNavBarView *nav = [ZXYNavBarView navBarViewWithType:ShowDirectionHorizontal];
    return nav;
}
+ (instancetype)navBarViewWithType:(ShowDirectionType)type{
    switch (type) {
        case 0:
        {
            ZXYNavBarView *nav = [[NSBundle mainBundle] loadNibNamed:@"ZXYHorizontalNavBar" owner:self options:nil].lastObject;
            nav.type = ShowDirectionHorizontal;
            return nav;
        }
            
        case 1:
        {
            ZXYNavBarView *nav = [[NSBundle mainBundle] loadNibNamed:@"ZXYVerticalNavBar" owner:self options:nil].lastObject;
            nav.type = ShowDirectionVertical;
            return nav;
        }
        default:
            break;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.titleView.subviews.count == 0) {
        [self setupTitle];
        [self scrollViewDidEndScrollingAnimation:self.contentView];
    }
}

- (void)setupTitle
{
    // 定义临时变量
    CGFloat itemX;
    CGFloat itemY;
    CGFloat itemH;
    CGFloat itemW;
    BOOL preferMethod = [_delegate respondsToSelector:@selector(navBarView:titleAtIndex:)];
    if (_type == ShowDirectionHorizontal) {
        itemW = 100;
        itemY = 0;
        itemH = self.titleView.frame.size.height;
        for (NSInteger i = 0; i < _delegate.childViewControllers.count; i++) {
            ZXYNavBarItem *item = [[ZXYNavBarItem alloc] init];
            NSString *title;
            if (preferMethod) {
                title = [_delegate navBarView:self titleAtIndex:i];
            }
            if (title.length != 0) {
                [item setTitle:title forState:UIControlStateNormal];
            }else{
                [item setTitle:[_delegate.childViewControllers[i] title] forState:UIControlStateNormal];
            }
            
            itemX = i * itemW;
            item.frame = CGRectMake(itemX, itemY, itemW, itemH);
            [item setTitleColor:_titleColor forState:UIControlStateNormal];
            item.selectedColor = _selectedColor;
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            
            item.tag = i;
            [self.titleView addSubview:item];
            
            if (i == 0) { // 最前面的item
                item.scale = 1.0;
            }
        }
        
        // 设置contentSize
        self.titleView.contentSize = CGSizeMake(_delegate.childViewControllers.count * itemW, 0);
        self.contentView.contentSize = CGSizeMake(_delegate.childViewControllers.count * [UIScreen mainScreen].bounds.size.width, 0);
    }
    
}

- (void)itemClick:(ZXYNavBarItem *)item
{
    // 取出被点击item的索引
    NSInteger index = item.tag;
    
    // 让底部的内容scrollView滚动到对应位置
    CGPoint offset = self.contentView.contentOffset;
    offset.x = index * self.contentView.frame.size.width;
    [self.contentView setContentOffset:offset animated:YES];
}
#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_type == ShowDirectionHorizontal) {
        CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
        if (scale < 0 || scale > self.titleView.subviews.count - 1) return;
        
        NSInteger leftIndex = scale;
        ZXYNavBarItem *leftitem = self.titleView.subviews[leftIndex];
        
        NSInteger rightIndex = leftIndex + 1;
        ZXYNavBarItem *rightitem = (rightIndex == self.titleView.subviews.count) ? nil : self.titleView.subviews[rightIndex];
        

        CGFloat rightScale = scale - leftIndex;
        CGFloat leftScale = 1 - rightScale;
        
    
        leftitem.scale = leftScale;
        rightitem.scale = rightScale;
    }
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index;
    ZXYNavBarItem *item;
    if (_type == ShowDirectionHorizontal) {
        
        index = offsetX / width;
        item = self.titleView.subviews[index];
        CGPoint offset = self.titleView.contentOffset;
        offset.x = item.center.x - width * 0.5;
    
        if (offset.x < 0) offset.x = 0;
        CGFloat maxTitleOffsetX = self.titleView.contentSize.width - width;
        if (offset.x > maxTitleOffsetX) offset.x = maxTitleOffsetX;
        [self.titleView setContentOffset:offset animated:YES];
        // 其他item回到最初的状态
        for (ZXYNavBarItem *otherItem in self.titleView.subviews) {
            if (otherItem != item) otherItem.scale = 0.0;
        }
        
        UIViewController *showVc = _delegate.childViewControllers[index];
        if (showVc.view.superview) return;
        showVc.view.frame = CGRectMake(offsetX, 0, width, height);
        [scrollView addSubview:showVc.view];
        if ([_delegate respondsToSelector:@selector(navBarView:didScrollAtIndexPath:)]) {
            [_delegate navBarView:self didScrollAtIndexPath:index];
        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.titleView.backgroundColor = backColor;
}


@end
