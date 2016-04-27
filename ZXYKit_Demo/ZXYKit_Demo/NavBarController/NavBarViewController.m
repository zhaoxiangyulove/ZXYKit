//
//  NavBarViewController.m
//  ZXYKit_Demo
//
//  Created by 赵翔宇 on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NavBarViewController.h"
#import "ZXYNavBarView.h"
#import "TestTableViewController.h"

@interface NavBarViewController ()<ZXYNavBarViewDelegate>

@property (nonatomic, weak) ZXYNavBarView *navBarView;

@end

@implementation NavBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    [self setupChildVc];
    [self navBarView];
}

- (void)setupChildVc
{
    TestTableViewController *table1 = [[TestTableViewController alloc] init];
    table1.title = @"table1";
    [self addChildViewController:table1];
    
    TestTableViewController *table2 = [[TestTableViewController alloc] init];
    table2.title = @"table2";
    [self addChildViewController:table2];
    
    TestTableViewController *table3 = [[TestTableViewController alloc] init];
    table3.title = @"table3";
    [self addChildViewController:table3];
    
    TestTableViewController *table4 = [[TestTableViewController alloc] init];
    table4.title = @"table4";
    [self addChildViewController:table4];
    
    TestTableViewController *table5 = [[TestTableViewController alloc] init];
    table5.title = @"table5";
    [self addChildViewController:table5];
    
    TestTableViewController *table6 = [[TestTableViewController alloc] init];
    table6.title = @"table6";
    [self addChildViewController:table6];
    
    TestTableViewController *table7 = [[TestTableViewController alloc] init];
    table7.title = @"table7";
    [self addChildViewController:table7];
}

- (ZXYNavBarView *)navBarView {
    if(_navBarView == nil) {
        ZXYNavBarView *navBar = [ZXYNavBarView navBarView];
        navBar.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        navBar.delegate = self;
        navBar.titleColor = [UIColor redColor];
        navBar.selectedColor = [UIColor greenColor];
        navBar.backColor = [UIColor lightGrayColor];
        NSLog(@"%@",self.childViewControllers);
        [self.view addSubview:navBar];
        _navBarView = navBar;
        
    }
    return _navBarView;
}

@end
