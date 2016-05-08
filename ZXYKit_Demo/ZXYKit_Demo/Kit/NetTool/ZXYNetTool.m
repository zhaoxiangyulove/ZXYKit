//
//  ZXYNetTool.m
//  OldFriends
//
//  Created by 赵翔宇 on 16/5/5.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//


#import "ZXYNetTool.h"


@interface ZXYNetTool ()
/** task array */
@property (nonatomic, strong) NSMutableArray<ZXYNetTask *> *tasks;

@end

@implementation ZXYNetTool

static ZXYNetTool *tool = nil;
+ (instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[ZXYNetTool alloc] init];
    });
    return tool;
}

+ (void)downloadWithURL:(NSURL *)url
                    progress:(ZXYDownloadProgressBlock)progressBlock
                   completed:(ZXYDownloadCompletedBlock)completedBlock{
    ZXYNetTool *netTool = [self shareTool];
    ZXYNetTask *task = [ZXYNetTask taskWithWithURL:url progress:progressBlock completed:^(NSData *data, NSError *error, BOOL finished) {
        completedBlock(data, error, finished);
        if ([netTool.tasks containsObject:task]){
           [netTool.tasks removeObject:task];
        }
    }];
    if (task == nil) return;
    [netTool startLoadingWithTask:task];
    
}

- (void)startLoadingWithTask:(ZXYNetTask *)task{
    [self.tasks addObject:task];
    [task start];
}

+ (void)pauseWithURL:(NSURL *)url{
    [[self shareTool] pauseWithURL:url];
}

- (void)pauseWithURL:(NSURL *)url{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(_tasks.count, queue, ^(size_t index) {
        ZXYNetTask *task = _tasks[index];
        if ([task.url.absoluteString isEqualToString:url.absoluteString]) {
            [task pause];
        }
        NSLog(@"%@", [NSThread currentThread]);
    });
}

- (NSMutableArray<ZXYNetTask *> *)tasks {
	if(_tasks == nil) {
		_tasks = [[NSMutableArray<ZXYNetTask *> alloc] init];
	}
	return _tasks;
}

@end
