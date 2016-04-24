//
//  ZXYTabBarController.m
//  ZXYTabBar
//
//  Created by 赵翔宇 on 16/4/23.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYTabBarController.h"
#import "ZXYTabBar.h"

@interface ZXYTabBarController ()<ZXYTabBarDelegate>
/** <#注释#> */
@property (nonatomic, strong) ZXYTabBar *bar;

@end

@implementation ZXYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self setUpAllChildViewController];
    // 自定义tabBar
    [self setUpTabBar];
    // Do any additional setup after loading the view.
    
}

#pragma mark - 自定义tabBar
- (void)setUpTabBar
{
    
    ZXYTabBar *tabBar = [[ZXYTabBar alloc] init];
    
    tabBar.delegate = self;
    tabBar.selectedBackColor = [UIColor greenColor];
    
    tabBar.backgroundColor = [UIColor orangeColor];
    _bar = tabBar;
    
    [self.view addSubview:tabBar];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZXYTabBarItem *item = [_bar.items objectAtIndex:0];
    item.badgeValue = 100;
}
- (CGSize)tabBar:(ZXYTabBar *)tabBar sizeForItemAtIndex:(NSInteger)index{
//    if (index == 2) {
//        return CGSizeMake(100,49);
//    }
    return CGSizeZero;
}
- (void)tabBar:(ZXYTabBar *)tabBar didClickItem:(ZXYTabBarItem *)item{
    
}
-(void)tabBar:(ZXYTabBar *)tabBar didRomveItemGooView:(ZXYTabBarItem *)item{
    item.badgeValue = 1;
}







#pragma mark - 添加所有子控制器
// tabBar上面按钮的图片尺寸是由规定，不能超过44
- (void)setUpAllChildViewController
{
    // 购彩大厅
    UIViewController *hall = [[UIViewController alloc] init];
    
    [self setUpOneChildViewController:hall image:[UIImage imageNamed:@"TabBar_LotteryHall_new"] selImage:[UIImage imageNamed:@"TabBar_LotteryHall_selected_new"] title:@"购彩大厅"];
    
    
    // 竞技场
    UIViewController *arena = [[UIViewController alloc] init];
    
    [self setUpOneChildViewController:arena image:[UIImage imageNamed:@"TabBar_Arena_new"] selImage:[UIImage imageNamed:@"TabBar_Arena_selected_new"] title:nil];
    
    arena.view.backgroundColor = [UIColor purpleColor];
    
    
    // 发现
    UIViewController *discover = [[UIViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"TabBar_Discovery_new"] selImage:[UIImage imageNamed:@"TabBar_Discovery_selected_new"] title:@"发现"];
    
    // 开奖信息
    UIViewController *history = [[UIViewController alloc] init];
    [self setUpOneChildViewController:history image:[UIImage imageNamed:@"TabBar_History_new"] selImage:[UIImage imageNamed:@"TabBar_History_selected_new"] title:@"开奖信息"];
    
    // 我的彩票
    UIViewController *myLottery = [[UIViewController alloc] init];
    [self setUpOneChildViewController:myLottery image:[UIImage imageNamed:@"TabBar_MyLottery_new"] selImage:[UIImage imageNamed:@"TabBar_MyLottery_selected_new"] title:@"我的彩票"];

}

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title
{
    
    vc.navigationItem.title = title;
    
    // 描述对应按钮的内容
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selImage;
    
//    // 记录所有控制器对应按钮的内容
//    [self.items addObject:vc.tabBarItem];
    
    vc.view.backgroundColor = [self randomColor];
    
    // 把控制器包装成导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // 如果要设置背景图片，必须填UIBarMetricsDefault,默认导航控制器的子控制器的view尺寸会变化。
    // 设置导航条背景图片，一定要在导航条显示之前设置
    //    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    [self addChildViewController:nav];
}

- (UIColor *)randomColor
{
    
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
