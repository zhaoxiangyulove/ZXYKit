//
//  ZXYNetTask.h
//  ZXYNetTool
//
//  Created by 赵翔宇 on 16/5/7.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZXYDownloadProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

typedef void(^ZXYDownloadCompletedBlock)(NSData *data, NSError *error, BOOL finished);

@protocol ZXYNetTaskDelegate <NSObject>


@end

@interface ZXYNetTask : NSObject

/** 代理 */
@property (nonatomic, weak) id<NSURLSessionDelegate> delegate;
/** URL */
@property (nonatomic, strong) NSURL *url;


+ (instancetype)taskWithWithURL:(NSURL *)url
                       progress:(ZXYDownloadProgressBlock)progressBlock
                      completed:(ZXYDownloadCompletedBlock)completedBlock;
- (void)start;
- (void)pause;
- (void)stop;
@end
