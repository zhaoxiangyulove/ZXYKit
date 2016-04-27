//
//  ZXYMenuViewController.m
//  test
//
//  Created by 赵翔宇 on 16/4/17.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYMenuViewController.h"
#import "ZXYMenuView.h"

#define kTargetR screenW * 0.6
#define kTargetL - screenW * 0.6
#define kMaxY 80
#define screenH  [UIScreen mainScreen].bounds.size.height
#define screenW  [UIScreen mainScreen].bounds.size.width
@interface ZXYMenuViewController ()
/** 视图 */
@property (nonatomic, weak) ZXYMenuView *menuView;
/** currentBackVC */
@property (nonatomic, weak) UIViewController *currentBackVC;
@end

@implementation ZXYMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.hidden = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_menuView.mainView addGestureRecognizer:tap];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

#pragma mark - pan手势

- (void)pan:(UIPanGestureRecognizer *)pan
{
    _currentBackVC = _menuView.mainView.frame.origin.x > 0?_leftVC:_rightVC;
    CGPoint transP = [pan translationInView:self.view];
    CGFloat offsetX = transP.x;
    // 修改mainV的Frame
    if (_leftVC && _menuView.mainView.frame.origin.x >= 0){
        _menuView.mainView.frame = [self frameWithOffsetX:offsetX];
        [_menuView.leftView addSubview:_leftVC.view];
    }
    if (_rightVC && _menuView.mainView.frame.origin.x <= 0){
        _menuView.mainView.frame = [self frameWithOffsetX:offsetX];
        [_menuView.rightView addSubview:_rightVC.view];
    }
    // 复位
    [pan setTranslation:CGPointZero inView:self.view];
    // 判断下当手势结束的时候位置
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat target = 0;
        if (_menuView.mainView.frame.origin.x > screenW * 0.4) {
            target = kTargetR;
        }else if (_menuView.mainView.frame.origin.x < - screenW * 0.4){
            target = kTargetL;
        }
        // 获取x轴偏移量
        CGFloat offsetX = target - _menuView.mainView.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            if (target == 0) {
                _menuView.mainView.frame = self.view.bounds;
            }else{
                _menuView.mainView.frame =[self frameWithOffsetX:offsetX];
            }
        } completion:^(BOOL finished) {
            if (target == 0)[_currentBackVC.view removeFromSuperview];
        }];
    }
    
}
#pragma mark - tap手势

- (void)tap
{
    // 还原
    if (_menuView.mainView.frame.origin.x != 0) {
        [UIView animateWithDuration:0.25 animations:^{
            _menuView.mainView.frame = self.view.bounds;
        }completion:^(BOOL finished) {
            [_currentBackVC.view removeFromSuperview];
        }];
    }
}
/**
 *  根据offsetX计算mainView的Frame
 *
 *  @param offsetX x轴偏移量
 *
 *  @return frame
 */
- (CGRect)frameWithOffsetX:(CGFloat)offsetX
{
    CGRect frame = _menuView.mainView.frame;
    CGFloat offsetY = offsetX * kMaxY / screenW;
    CGFloat preH = frame.size.height;
    CGFloat preW = frame.size.width;
    CGFloat curH = preH - 2 * offsetY;
    if (frame.origin.x < 0) {
        curH = preH + 2 * offsetY;
    }
    // 获取尺寸的缩放比例
    CGFloat scale = curH / preH;
    // 获取当前的宽度
    CGFloat curW = preW * scale;
    // 更改frame
    frame.origin.x += offsetX;
    frame.origin.y = (screenH - curH) / 2 + 10;
    frame.size.height = curH;
    frame.size.width = curW;
    return frame;
}



#pragma mark - set方法

- (void)setMainVC:(UIViewController *)mainVC{
    [self addChildViewController:mainVC];
    _mainVC = mainVC;
    mainVC.view.frame = _menuView.mainView.frame;
    [_menuView.mainView addSubview:mainVC.view];
}
- (void)setLeftVC:(UIViewController *)leftVC{
    [self addChildViewController:leftVC];
    _leftVC = leftVC;
    leftVC.view.frame = _menuView.leftView.frame;
}
- (void)setRightVC:(UIViewController *)rightVC{
    [self addChildViewController:rightVC];
    _rightVC = rightVC;
    rightVC.view.frame = _menuView.rightView.frame;
}
- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.view.backgroundColor = backColor;
}

#pragma mark - 懒加载

- (ZXYMenuView *)menuView {
	if(_menuView == nil) {
		ZXYMenuView *view = [[ZXYMenuView alloc] init];
        view.frame = [UIScreen mainScreen].bounds;
        [self.view addSubview:view];
        _menuView = view;
	}
	return _menuView;
}

@end
