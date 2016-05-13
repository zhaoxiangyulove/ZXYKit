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
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseImage) name:@"chooseImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"back" object:nil];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)chooseImage{
    if ([_clipDelegate respondsToSelector:@selector(pickImageViewController:didFinishPickingOriginalImage:)]) {
        [_clipDelegate pickImageViewController:self didFinishPickingOriginalImage:_clipView.image];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGRect frame = CGRectMake(leftMargin - _clipView.offX, topMargin - _clipView.offY, clipBorder, clipBorder);
        // 开启上下文
        UIImage *image = [_clipView.image clipImageWithFrame:frame scale:_clipView.scaleRate];
        if (_border != 0) {
            image = [image clipImageWithBorderWidth:_border*_clipView.scaleRate borderColor:_borderColor cornerRadius:_radiusRate];
        }
        //生成一张新的图片
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_clipDelegate respondsToSelector:@selector(pickImageViewController:didFinishPickingClipImage:)]) {
                [_clipDelegate pickImageViewController:self didFinishPickingClipImage: image];
            }
        });
        
        [self back];
        [self dismissViewControllerAnimated:YES completion:nil];

    });
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
@end
