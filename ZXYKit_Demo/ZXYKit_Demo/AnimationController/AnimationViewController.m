//
//  AnimationViewController.m
//  ZXYKit_Demo
//
//  Created by 赵翔宇 on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AnimationViewController.h"
#import "Animation.h"

@interface AnimationViewController ()
/** testView */
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = -1 / 500.0;
    _redView.layer.transform = transfrom;
    _redView.layer.borderWidth = 5;
    _redView.layer.borderColor = [UIColor yellowColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)start:(UIButton *)sender {
    
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
    }];
    
    
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
