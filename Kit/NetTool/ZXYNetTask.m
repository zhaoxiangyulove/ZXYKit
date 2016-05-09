//
//  ZXYNetTask.m
//  ZXYNetTool
//
//  Created by 赵翔宇 on 16/5/7.
//  Copyright © 2016年 赵翔宇. All rights reserved.
//

#define ZXYDownloadRecordPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"download.plist"]

#define ZXYFilename _url.absoluteString.md5String

// 文件的存放路径（caches）
#define ZXYFilepath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:ZXYFilename]

#import "ZXYNetTask.h"
#import "NSString+Hash.h"

@interface ZXYNetTask ()<NSURLSessionDataDelegate>

/** progressBlock */
@property (nonatomic, copy) ZXYDownloadProgressBlock downloadProgressBlock;
/** progressBlock */
@property (nonatomic, copy) ZXYDownloadCompletedBlock downloadCompletedBlock;
/** 写文件的流对象 */
@property (nonatomic, strong) NSOutputStream *stream;
/** session */
@property (nonatomic, strong) NSURLSession *session;
/** 文件的总长度 */
@property (nonatomic, assign) NSInteger totalLength;
/** 已下载的长度 */
@property (nonatomic, assign) NSInteger downloadLength;
/** downloadTask */
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;

@end

@implementation ZXYNetTask

+ (instancetype)taskWithWithURL:(NSURL *)url progress:(ZXYDownloadProgressBlock)progressBlock completed:(ZXYDownloadCompletedBlock)completedBlock{
    ZXYNetTask *task = [[self alloc] initWithWithURL:url progress:progressBlock completed:completedBlock];
    return task;
}

- (instancetype)initWithWithURL:(NSURL *)url progress:(ZXYDownloadProgressBlock)progressBlock completed:(ZXYDownloadCompletedBlock)completedBlock
{
    self = [super init];
    if (self) {
        _url = url;
        self.downloadProgressBlock = progressBlock;
        self.downloadCompletedBlock = completedBlock;
        _totalLength = [[NSDictionary dictionaryWithContentsOfFile:ZXYDownloadRecordPath][ZXYFilename] integerValue];
        _downloadLength = [[[NSFileManager defaultManager] attributesOfItemAtPath:ZXYFilepath error:nil][NSFileSize] integerValue];
        
        if (_totalLength &&  _downloadLength == _totalLength) {
            progressBlock(_downloadLength, _totalLength);
            NSData *data = [NSData dataWithContentsOfFile:ZXYFilepath];
            completedBlock(data, nil, YES);
            return nil;
        }
        
        // 创建请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // 设置请求头
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", _downloadLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        // 创建一个Data任务
        self.downloadTask = [self.session dataTaskWithRequest:request];
    }
    return self;
}

- (void)start{
    [_downloadTask resume];
}
- (void)pause{
    [_downloadTask suspend];
}
- (void)stop{
    // 清除任务
    [_downloadTask cancel];
    _downloadTask = nil;
    [self removeFile];
}
- (void)removeFile{
    [[NSFileManager defaultManager] removeItemAtPath:ZXYFilepath error:nil];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:ZXYDownloadRecordPath];
    [dict removeObjectForKey:ZXYFilename];
    [dict writeToFile:ZXYDownloadRecordPath atomically:YES];
}
#pragma mark - <NSURLSessionDataDelegate>
/**
 * 接收到响应
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    // 打开流
    [self.stream open];
    
    // 获得服务器这次请求 返回数据的总长度
    if (_totalLength == 0) {
        _totalLength = [response.allHeaderFields[@"Content-Length"] integerValue];
    }
    // 存储总长度
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:ZXYDownloadRecordPath];
    if (dict == nil) dict = [NSMutableDictionary dictionary];
    dict[ZXYFilename] = @(_totalLength);
    [dict writeToFile:ZXYDownloadRecordPath atomically:YES];
    
    // 接收这个请求，允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * 接收到服务器返回的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // 写入数据
    [self.stream write:data.bytes maxLength:data.length];
    _downloadLength = [[[NSFileManager defaultManager] attributesOfItemAtPath:ZXYFilepath error:nil][NSFileSize] integerValue];
    // 反馈下载进度
    _downloadProgressBlock(_downloadLength, _totalLength);

}

/**
 * 请求完毕（成功\失败）
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    // 关闭流
    [_stream close];
    _stream = nil;
    
    //回调完成Block
    NSData *data = [NSData dataWithContentsOfFile:ZXYFilepath];
    _downloadCompletedBlock(data, error, YES);
    
    // 清除任务
    _downloadTask = nil;
}

#pragma mark - 懒加载

- (NSOutputStream *)stream
{
    if (!_stream) {
        _stream = [NSOutputStream outputStreamToFileAtPath:ZXYFilepath append:YES];
    }
    return _stream;
}

- (NSURLSession *)session
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}


@end
