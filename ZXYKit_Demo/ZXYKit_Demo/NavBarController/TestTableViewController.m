//
//  TestTableViewController.m
//  ZXYKit_Demo
//
//  Created by 赵翔宇 on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TestTableViewController.h"

@interface TestTableViewController ()

@end

@implementation TestTableViewController


static NSString *ID = @"test";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.title, indexPath.row];
    return cell;
}

@end
