//
//  ZXYGraphView.h
//  test
//
//  Created by 赵翔宇 on 16/4/18.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXYGraphModel;
typedef enum{
    ZXYGraphViewPie,
    ZXYGraphViewBar,
    ZXYGraphViewLine
    
}ZXYGraphViewType;

@interface ZXYGraphView : UIView

/** 数据组 */
@property (nonatomic, strong) NSArray<ZXYGraphModel *> *values;


/** 类型 */
@property (nonatomic, assign) ZXYGraphViewType type;

@end
