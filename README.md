# ZXYKit
# 问题反馈群：70498704
# AnimationKit
- 使用方法
    - 导入`ZXYAnimationKit`文件夹
    - 引入`Animation.h`头文件
    - 使用layer的实例方法

```objc
- (void)makeAnimations:(void(^)(ZXYAnimationMaker *make))block;
 ```
 - 参考代码

```objc
    [someLayer makeAnimations:^(ZXYAnimationMaker *make) {
//        make.position.from(CGPointMake(100, 100)).to(CGPointMake(arc4random_uniform(200), arc4random_uniform(200)));
//        make.rotationY.from(0.3).to(M_PI);
//        make.rotation.to(M_PI_2);
//        make.rotationX.values(@[@(M_PI_4),@(M_PI_2),@(M_PI_4 *3)]);
//        make.bounds.to(CGRectMake(0, 0, 200, 200));
//        make.scale.to(0.5);
//        make.hidden.to(YES);
//        make.submakeScale.to(0.5);
//        make.translationX.to(100);
//        make.borderColor.to([UIColor lightGrayColor].CGColor);
//        make.borderWidth.to(20);
//        make.opacity.to(0);

//        make.backcolor.to([UIColor lightGrayColor].CGColor);

//        make.repeatCount(3);
//        make.duration(1);
//        make.autoreverses(YES);
    }];

 ```
