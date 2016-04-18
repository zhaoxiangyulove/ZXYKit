//
//  GraphViewController.m
//  ZXYKit_Demo
//
//  Created by 赵翔宇 on 16/4/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GraphViewController.h"
#import "ZXYGraphView.h"
#import "ZXYGraphModel.h"
#import "UIColor+ZXYColor.h"

@interface GraphViewController ()
/** model数组 */
@property (nonatomic, strong) NSMutableArray<ZXYGraphModel *> *models;
@property (weak, nonatomic) IBOutlet ZXYGraphView *graphView;
@property (weak, nonatomic) IBOutlet UITextField *titleFeild;
@property (weak, nonatomic) IBOutlet UITextField *valueFeild;

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.graphView.type = ZXYGraphViewPie;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addGraphModel:(UIButton *)sender {
    ZXYGraphModel *model = [ZXYGraphModel modelWithValue:self.valueFeild.text.floatValue color:[UIColor colorRandom] title:self.titleFeild.text];
    [self.models addObject:model];
    self.graphView.values = _models;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray<ZXYGraphModel *> *)models {
	if(_models == nil) {
		_models = [[NSMutableArray<ZXYGraphModel *> alloc] init];
	}
	return _models;
}

@end
