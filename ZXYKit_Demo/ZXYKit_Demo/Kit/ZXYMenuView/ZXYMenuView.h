//
//  ZXYMenuView.h
//  test
//
//  Created by 赵翔宇 on 16/4/17.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYMenuView : UIView

/** 主视图 */
@property (nonatomic, weak, readonly) UIView *mainView;
/** 左视图 */
@property (nonatomic, weak, readonly) UIView *leftView;
/** 右视图 */
@property (nonatomic, weak, readonly) UIView *rightView;

@end
