# ZXYKit
# 问题反馈群：70498704
# 平均两天会出一个新框架，欢迎来群提意见，想法！
## AnimationKit
- 使用方法
    - 导入`ZXYAnimationKit`文件夹
    - 引入`Animation.h`头文件
    - 使用layer的实例方法

```objc
- (void)makeAnimations:(void (^)(ZXYAnimationMaker *))block completion:(void (^)(BOOL finished))completion;
```

 - 参考代码

```objc

      [_redView.layer makeAnimations:^(ZXYAnimationMaker *make) {
//        make.position.from(CGPointMake(100, 100)).to(CGPointMake(arc4random_uniform(200), arc4random_uniform(200)));
//        make.rotationY.from(0.3).to(M_PI);
//        make.rotation.to(M_PI_2);
        make.repeatCount(3);
        make.duration(1);
        make.autoreverses(YES);
//        make.rotationX.values(@[@(M_PI_4),@(M_PI_2),@(M_PI_4 *3)]);
//        make.bounds.to(CGRectMake(0, 0, 200, 200));
//        make.scale.to(0.5);
//        make.hidden.to(YES);
//        make.submakeScale.to(0.5);
        make.translationX.to(100);
//        make.borderColor.to([UIColor lightGrayColor].CGColor);
//        make.borderWidth.to(20);
//        make.opacity.to(0);

//        make.backcolor.to([UIColor lightGrayColor].CGColor);
    } completion:^(BOOL finished) {
        NSLog(@"complete");
    }];
    
 ```


##  ZXYTabBar
- 效果图 <br/>
![Smaller icon](http://g.hiphotos.baidu.com/image/pic/item/7dd98d1001e939014793b7be7cec54e737d19698.jpg)

- 使用方法
    - 导入`ZXYTabBar`文件夹
    - 创建一个自定义TabBarController；
    - 引入`ZXYTabBar.h`头文件，并遵守 ` <ZXYTabBarDelegate>`
    - 使用代理方法

```objc
- (void)setUpTabBar
{
    ZXYTabBar *tabBar = [[ZXYTabBar alloc] init];
    tabBar.delegate = self;
    //设置选中背景，则有背景颜色，不设置为无
    tabBar.selectedBackColor = [UIColor greenColor];
    tabBar.backgroundColor = [UIColor orangeColor];
    _bar = tabBar;
    [self.view addSubview:tabBar];
}
 ```
 - 参考代理相关代码：
 - 选择设置某个item的size

```objc
- (CGSize)tabBar:(ZXYTabBar *)tabBar sizeForItemAtIndex:(NSInteger)index{
//    if (index == 2) {
//        return CGSizeMake(100,49);
//    }
    return CGSizeZero;
}

 ```
  - 将item的badgeView拖拽出去消失后要做的事

```objc
-(void)tabBar:(ZXYTabBar *)tabBar didRomveItemGooView:(ZXYTabBarItem *)item{
    item.badgeValue = 1;
}
 ```
   - 点击某个item是要做的事

```objc
- (void)tabBar:(ZXYTabBar *)tabBar didClickItem:(ZXYTabBarItem *)item；

 ```
