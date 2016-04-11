//
//  ZXYPageView.m
//  Shop
//
//  Created by 赵翔宇 on 16/4/8.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYPageView.h"

@interface ZXYPageView ()<UIScrollViewDelegate>
{
//    NSInteger count;
    NSInteger currentIndex;
}
/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *contentView;
/** 文本栏 */
@property (nonatomic, strong) UILabel *textLabel;
/** page */
@property (nonatomic, strong) UIPageControl *pageControl;
/** 计时器 */
@property (nonatomic, weak) NSTimer *timer;


@end

static NSInteger imageBtnCount = 3;

@implementation ZXYPageView

+ (instancetype)pageView{
    return  [[self alloc] init];
}
+(instancetype)pageViewWithImages:(NSArray<UIImage *> *)images{
    return [[self alloc] initWithImages:images];
}
- (instancetype)initWithImages:(NSArray<UIImage *> *)images
{
    self = [super init];
    if (self) {
        self.images = images;
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 更新
- (void)setUpSubviews{
    [self addSubview:self.contentView];
    
    
    
}

/**
 *  更新子控件布局
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    if(CGRectEqualToRect(CGRectZero, _contentViewFrame)) _contentView.frame = self.bounds;
    if (_textLabel) _textLabel.frame = CGRectMake(0, self.bounds.size.height * 0.85, self.bounds.size.width, self.bounds.size.height * 0.15);
    if (_pageControl){
        CGRect bounds = _pageControl.bounds;
        _pageControl.frame = CGRectMake(self.bounds.size.width - bounds.size.width - 10, self.bounds.size.height * 0.85, bounds.size.width, self.bounds.size.height * 0.15);
    }
    if (_scrollDirection == ScrollDirectionVertical) {
        _contentView.contentSize = CGSizeMake(_contentView.frame.size.width, imageBtnCount * _contentView.frame.size.height);
        _contentView.contentOffset = CGPointMake(0, _contentView.frame.size.height);
    }else{
        _contentView.contentSize = CGSizeMake(imageBtnCount * _contentView.frame.size.width, _contentView.frame.size.height);
        _contentView.contentOffset = CGPointMake(_contentView.frame.size.width, 0);
    }
    for (int i = 0; i < imageBtnCount; i++) {
        UIButton *button = _contentView.subviews[i];
        if (_scrollDirection == ScrollDirectionVertical) {
            button.frame = CGRectMake(0, i * _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        }else{
            button.frame = CGRectMake(i * _contentView.frame.size.width,0, _contentView.frame.size.width, _contentView.frame.size.height);
        }
    }
    if (_images.count != 0) {
        [self updateContent];
        [self startTimer];
    }
   
}
/**
 *  更新图片
 */
- (void)updateContent{
    for (int i = 0; i < imageBtnCount; i++) {
        UIButton *btn = self.contentView.subviews[i];
        NSInteger index = currentIndex;
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        if (index < 0) {
            index = self.images.count - 1;
        } else if (index >= self.images.count) {
            index = 0;
        }
        btn.tag = index;
//        btn.transform = CGAffineTransformIdentity;
        [btn setImage:self.images[index] forState:UIControlStateNormal];
        [btn setImage:self.images[index] forState:UIControlStateHighlighted];
        
    }
    if (_scrollDirection == ScrollDirectionVertical) {
        _contentView.contentOffset = CGPointMake(0, self.frame.size.height);
    }else {
        _contentView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    
}

#pragma mark - Timer
- (void)startTimer{
    if (_interval == 0) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(nextImageBtn) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)nextImageBtn{
    if (self.scrollDirection == ScrollDirectionVertical) {
        [_contentView setContentOffset:CGPointMake(0, 2.01 * self.frame.size.height) animated:YES];
    } else {
        [_contentView setContentOffset:CGPointMake(2.01 * self.frame.size.width, 0) animated:YES];
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat minDistance = CGFLOAT_MAX;
    NSInteger lastIndex = currentIndex;
    for (int i = 0; i < imageBtnCount; i++) {
        CGFloat distance;
        UIButton *btn = _contentView.subviews[i];
        if (self.scrollDirection == ScrollDirectionVertical) {
            distance = btn.frame.origin.y - _contentView.contentOffset.y;
        }else{
            distance = btn.frame.origin.x - _contentView.contentOffset.x;
        }
        
        if (ABS(distance) < minDistance) {
            minDistance = ABS(distance);
            currentIndex = btn.tag;
//            if (_interval != 0) {
//                CGFloat scale =1 + distance/_contentView.bounds.size.width;
//                btn.transform = CGAffineTransformMakeScale(scale, scale);
//            }
        }
    }
    if (currentIndex != lastIndex) {
        [self.delegate ZXYPageView:self currentPage:currentIndex];
        if (self.textLabel) self.textLabel.text = self.titles[currentIndex];
        if (self.pageControl) self.pageControl.currentPage = currentIndex;
    }
    
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}
#pragma mark - set方法

- (void)setImages:(NSArray *)images{
    _images = images;
    currentIndex = 0;
    if ([self.dataSource ZXYPageViewPreferShowPageControl:self]) {
        [self addSubview:self.pageControl];
    }
    
    
}
-(void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    [self insertSubview:self.textLabel aboveSubview:_contentView];
}
- (void)setContentViewFrame:(CGRect)contentViewFrame{
    _contentViewFrame = contentViewFrame;
    self.contentView.frame = contentViewFrame;
}

#pragma mark - 懒加载


- (UIScrollView *)contentView {
	if(_contentView == nil) {
		UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        for (int i = 0; i < imageBtnCount; i++) {
            UIButton *button = [[UIButton alloc] init];
            [button addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:button];
        }
        _contentView = scrollView;
	}
	return _contentView;
}
- (void)imageBtnClick:(UIButton *)imageBtn{
    [self.delegate ZXYPageView:self didClickAtCurrentPage:imageBtn.tag];
}


- (UILabel *)textLabel {
	if(_textLabel == nil) {
		UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5];
        self.textLabel = label;
	}
	return _textLabel;
}

- (UIPageControl *)pageControl {
    if(_pageControl == nil) {
		UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.enabled = NO;
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.pageIndicatorTintColor = [UIColor blueColor];
        pageControl.numberOfPages = self.images.count;
        [pageControl sizeToFit];
        self.pageControl = pageControl;
	}
	return _pageControl;
}

@end
