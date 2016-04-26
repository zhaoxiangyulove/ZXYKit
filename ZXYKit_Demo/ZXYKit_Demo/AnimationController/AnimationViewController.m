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

/** shapeLayer */
@property (nonatomic, weak) CAShapeLayer *shapeLayer;

/** path */
@property (nonatomic, strong) UIBezierPath *path;

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
    self.shapeLayer.path = self.path.CGPath;
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
    } completion:^(BOOL finished) {
//        NSLog(@"complete");
    }];
    
    [_shapeLayer makeAnimations:^(ZXYAnimationMaker *make) {
        make.strokeEnd.to(0.5);
        make.duration(3);
    } completion:^(BOOL finished) {
        
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint locationP = [touch locationInView:self.view];
//    [self.path moveToPoint:locationP];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint targetP = [touch locationInView:self.view];
//    [self.path addLineToPoint:targetP];
}


- (CAShapeLayer *)shapeLayer {
	if(_shapeLayer == nil) {
		CAShapeLayer *layer = [CAShapeLayer layer];
        [self.view.layer addSublayer:layer];
        _shapeLayer = layer;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.fillColor = [UIColor greenColor].CGColor;
        _shapeLayer.lineWidth = 4;
	}
	return _shapeLayer;
}

- (UIBezierPath *)path {
	if(_path == nil) {
		_path = [UIBezierPath bezierPath];
        [_path moveToPoint:CGPointMake(2, 500)];
        [_path addLineToPoint:CGPointMake(400, 500)];
        [_path stroke];
        
	}
	return _path;
}

@end
