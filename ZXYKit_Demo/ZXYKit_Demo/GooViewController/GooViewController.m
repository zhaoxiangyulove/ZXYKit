//
//  GooViewController.m
//  ZXYKit_Demo
//
//  Created by 赵翔宇 on 16/4/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GooViewController.h"
#import "ZXYGooView.h"

@interface GooViewController ()
@property (weak, nonatomic) IBOutlet ZXYGooView *gooView;

@end

@implementation GooViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _gooView.badgeValue = 100;
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
