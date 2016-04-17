//
//  MenuViewController.m
//  ZXYKit_Demo
//
//  Created by 赵翔宇 on 16/4/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableViewController *vc = [[UITableViewController alloc] init];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
    self.mainVC = navController;
    UIViewController *leftVC = [[UIViewController alloc] init];
    leftVC.view.backgroundColor = [UIColor redColor];
    self.leftVC = leftVC;
    UIViewController *rightVC = [[UIViewController alloc] init];
    rightVC.view.backgroundColor = [UIColor blueColor];
    self.rightVC = rightVC;
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
