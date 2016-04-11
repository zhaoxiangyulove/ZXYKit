//
//  PageViewController.m
//  ZXYKit_Demo
//
//  Created by 赵翔宇 on 16/4/11.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PageViewController.h"
#import "ZXYPageView.h"

@interface PageViewController ()<ZXYPageViewDelegate,ZXYPageViewDataSource>

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZXYPageView *scrollView = [[ZXYPageView alloc] init];
    //代理可以不设置
    scrollView.delegate = self;
    scrollView.dataSource = self;
    //时间间隔不设置或设置为0，均不轮播
    scrollView.interval = 2;
    scrollView.frame = CGRectMake(30, 100, 300, 130);
    scrollView.images = @[
                          [UIImage imageNamed:@"QQ20160411-1"],
                          [UIImage imageNamed:@"QQ20160411-2"],
                          [UIImage imageNamed:@"QQ20160411-3"],
                          ];
    //文字不设置则无文本框
    scrollView.titles = @[@"1",@"2",@"3"];
    [self.view addSubview:scrollView];
}

#pragma mark - <ZXYPageViewDelegate>

-(void)ZXYPageView:(ZXYPageView *)pageView currentPage:(NSInteger)currentPage{
        NSLog(@"currentPage:%ld",currentPage);
}

-(void)ZXYPageView:(ZXYPageView *)pageView didClickAtCurrentPage:(NSInteger)currentPage{
    NSLog(@"currentPage:%ld",currentPage);
}

#pragma mark - <ZXYPageViewDataSource>

-(BOOL)ZXYPageViewPreferShowPageControl:(ZXYPageView *)pageView{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
