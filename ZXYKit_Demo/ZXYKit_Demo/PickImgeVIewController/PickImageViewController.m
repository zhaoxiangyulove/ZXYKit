//
//  PickImageViewController.m
//  ZXYKit_Demo
//
//  Created by 赵翔宇 on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PickImageViewController.h"
#import "ZXYPickImageViewController.h"
#import "UIColor+ZXYColor.h"

@interface PickImageViewController ()<ZXYPickImageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *borderSlider;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation PickImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeColor:(UIButton *)sender {
    UIColor *color = [UIColor colorRandom];
    _colorView.backgroundColor = color;
}
- (IBAction)chooseImage:(UIButton *)sender {
    ZXYPickImageViewController *pickerVC = [ZXYPickImageViewController sharePickImageController];
    pickerVC.radiusRate = _slider.value;
    pickerVC.border = _borderSlider.value;
    pickerVC.borderColor = _colorView.backgroundColor;
    pickerVC.clipDelegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}
#pragma mark - <ZXYPickImageViewControllerDelegate>
- (void)pickImageViewController:(ZXYPickImageViewController *)picker didFinishPickingImage:(UIImage *)image{
    
    self.imageView.image = image;

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
