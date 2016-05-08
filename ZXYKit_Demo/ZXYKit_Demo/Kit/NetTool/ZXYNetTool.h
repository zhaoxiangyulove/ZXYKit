//
//  ZXYNetTool.h
//  OldFriends
//
//  Created by 赵翔宇 on 16/5/5.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXYNetTask.h"



@interface ZXYNetTool : NSObject

//+ (void)downloadWithURLString:(NSString *)URLString success:(void (^)(BOOL finished))completio completion:(void (^)(BOOL finished))completion;

+ (void)downloadWithURL:(NSURL *)url
                                        progress:(ZXYDownloadProgressBlock)progressBlock
                                       completed:(ZXYDownloadCompletedBlock)completedBlock;
+ (void)pauseWithURL:(NSURL *)url;
@end
