//
//  ZXYPickImageViewController.m
//  test
//
//  Created by 赵翔宇 on 16/4/19.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import "ZXYPickImageViewController.h"
#import "ZXYClipView.h"
#import "UIImage+ZXYImage.h"

#define clipBorder  250
#define screenH  [UIScreen mainScreen].bounds.size.height
#define screenW  [UIScreen mainScreen].bounds.size.width
#define leftMargin (screenW - clipBorder) * 0.5
#define rightMargin screenW * 0.5 + clipBorder*0.5
#define topMargin (screenH - clipBorder) * 0.5
#define bottomMargin screenH * 0.5 + clipBorder*0.5


@interface ZXYPickImageViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 截图视图 */
@property (nonatomic, strong) ZXYClipView *clipView;

@end

@implementation ZXYPickImageViewController

+ (instancetype)sharePickImageController{
    static ZXYPickImageViewController *picker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picker = [[ZXYPickImageViewController alloc] init];
    });
    return picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.delegate = self;
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseImage) name:@"chooseImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"back" object:nil];
}

- (void)chooseImage{
    CGRect frame = CGRectMake(leftMargin - _clipView.offX, topMargin - _clipView.offY, clipBorder, clipBorder);
    // 开启上下文
    UIImage *image = [_clipView.image clipImageWithFrame:frame scale:_clipView.scaleRate];
    image = [image clipImageWithBorderWidth:_border*_clipView.scaleRate borderColor:_borderColor cornerRadius:_radiusRate];
    //生成一张新的图片
    if ([self.clipDelegate respondsToSelector:@selector(pickImageViewController:didFinishPickingImage:)]) {
        [self.clipDelegate pickImageViewController:self didFinishPickingImage: image];
        [self back];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)back{
    [UIView animateWithDuration:0.2 animations:^{
        _clipView.transform = CGAffineTransformMakeTranslation(0, _clipView.frame.size.height);
    } completion:^(BOOL finished) {
        [self.clipView removeFromSuperview];
        self.clipView = nil;
    }];
    
}

#pragma mark - <UIImagePickerControllerDelegate>

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.clipView.image = image;
}


#pragma mark - 懒加载

- (ZXYClipView *)clipView {
	if(_clipView == nil) {
		_clipView = [ZXYClipView clipView];
        _clipView.frame = [UIScreen mainScreen].bounds;
        _clipView.transform = CGAffineTransformMakeTranslation(0, _clipView.frame.size.height);
        _clipView.radiusRate = _radiusRate;
        [self.view addSubview:_clipView];
        [UIView animateWithDuration:0.2 animations:^{
            _clipView.transform = CGAffineTransformIdentity;
        }];
	}
	return _clipView;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
