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
@end

@implementation ZXYMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.hidden = NO;
    // Do any additional setup after loading the view.
}

#pragma mark - pan手势

- (void)pan:(UIPanGestureRecognizer *)pan
{
    // 获取手势位置
    CGPoint transP = [pan translationInView:self.view];
    // 获取X轴偏移量
    CGFloat offsetX = transP.x;
    // 修改mainV的Frame
    if (_leftVC && offsetX > 0){
        _menuView.mainView.frame = [self frameWithOffsetX:offsetX];
    }
    if (_rightVC && offsetX < 0){
        _menuView.mainView.frame = [self frameWithOffsetX:offsetX];
    }
    // 复位
    [pan setTranslation:CGPointZero inView:self.view];
    // 判断下当手势结束的时候，定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        // 定位
        CGFloat target = 0;
        if (_menuView.mainView.frame.origin.x > screenW * 0.4) {
            target = kTargetR;
        }else if (_menuView.mainView.frame.origin.x < - screenW * 0.4){
            target = kTargetL;
        }
        // 获取x轴偏移量
        CGFloat offsetX = target - _menuView.mainView.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            _menuView.mainView.frame = target == 0?self.view.bounds:[self frameWithOffsetX:offsetX];
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
    // 获取上一次frame
    CGRect frame = _menuView.mainView.frame;
    // X轴每平移一点，Y轴需要移动
    CGFloat offsetY = offsetX * kMaxY / screenW;
    // 获取上一次的高度
    CGFloat preH = frame.size.height;
    // 获取上一次的宽度
    CGFloat preW = frame.size.width;
    // 获取当前的高度
    CGFloat curH = preH - 2 * offsetY;
    if (frame.origin.x < 0) { // 往左移动
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

#pragma mark - tap手势

- (void)tap
{
    // 还原
    if (_menuView.mainView.frame.origin.x != 0) {
        [UIView animateWithDuration:0.25 animations:^{
            _menuView.mainView.frame = self.view.bounds;
        }];
    }
}

#pragma mark - set方法

- (void)setMainVC:(UIViewController *)mainVC{
    [self addChildViewController:mainVC];
    _mainVC = mainVC;
    mainVC.view.frame = _menuView.mainView.frame;
    [_menuView.mainView addSubview:mainVC.view];
    // 添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_menuView.mainView addGestureRecognizer:tap];
    
}
- (void)setLeftVC:(UIViewController *)leftVC{
    [self addChildViewController:leftVC];
    _leftVC = leftVC;
    leftVC.view.frame = _menuView.leftView.frame;
    [_menuView.leftView addSubview:leftVC.view];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}
- (void)setRightVC:(UIViewController *)rightVC{
    [self addChildViewController:rightVC];
    _rightVC = rightVC;
    rightVC.view.frame = _menuView.rightView.frame;
    [_menuView.rightView addSubview:rightVC.view];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
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
