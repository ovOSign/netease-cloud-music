//
//  NetWorkUtils.m
//  App
//
//  Created by Yu on 15/12/1.
//  Copyright © 2015年 HangZhou QiYi Technology Co.,Ltd. All rights reserved.
//

#import "NetWorkUtils.h"

@interface NetWorkUtils ()

@property(strong,nonatomic)AFHTTPRequestOperationManager *manager;

@end

@implementation NetWorkUtils

//---------------------------网络请求------------------------------------------------//

+(AFHTTPRequestOperationManager*)shareInstance
{
    static NetWorkUtils *net=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        net=[[NetWorkUtils alloc] init];
        
        net.manager=[AFHTTPRequestOperationManager manager];
        
        // 设置返回格式
        net.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //这里是需要注意的一点，如果你的程序在解析的时候出现了错误，并打印了error的错误数据，多半是在设置接收格式的时候，少些了这一句代码。
        net.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    });
    
    return net.manager;
}

+(void)netWorkStatus:(void (^)(AFNetworkReachabilityStatus code))callback
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        //NSLog(@"%ld",(long)status);
        if (callback) {
            callback(status);
        }
        
    }];
    
}

///发送get请求
+(void)GetRequest:(NSString*)parameters Tag:(NSString*)tag callback:(void (^)(id res))callback
{
    [NetWorkUtils initWithTag:tag];
    
    NSString *url=[NetWorkUtils initUrl:nil];
    
    if (parameters&&parameters.length>0) {
        url=[NSString stringWithFormat:@"%@?%@",url,parameters];
    }
    [[NetWorkUtils shareInstance] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self successCallBack:responseObject callback:callback];
    } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
        [self failCallBack:error callback:callback];
    }];
}

///发送post请求
+(void)PostRequest:(id)parameters Tag:(NSString*)tag callback:(void (^)(id res))callback
{
    
    [[NetWorkUtils shareInstance].requestSerializer setValue:@"appver=1.5.0.75771" forHTTPHeaderField:@"Cookie"];
    [[NetWorkUtils shareInstance].requestSerializer setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
    [NetWorkUtils initWithTag:tag];
    
    NSMutableDictionary *dic=[NetWorkUtils initParameter:parameters];
    
    NSString *url=[NetWorkUtils initUrl:parameters];
    
    [[NetWorkUtils shareInstance] POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
        [self successCallBack:responseObject callback:callback];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        [self failCallBack:error callback:callback];
    }];
}

+(void)PostRequest:(NSString*)url  parameter:(NSMutableDictionary*)dic Tag:(NSString*)tag callback:(void (^)(id res))callback
{
    
    [[NetWorkUtils shareInstance].requestSerializer setValue:@"appver=1.5.0.75771" forHTTPHeaderField:@"Cookie"];
    [[NetWorkUtils shareInstance].requestSerializer setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
    [NetWorkUtils initWithTag:tag];
    
    [[NetWorkUtils shareInstance] POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
        [self successCallBack:responseObject callback:callback];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        [self failCallBack:error callback:callback];
    }];
}



///post发送图片
+(void)PostPhoto:(id)parameters Tag:(NSString*)tag data:(NSData*)data callback:(void (^)(id res))callback
{
    [NetWorkUtils initWithTag:tag];
    
    NSMutableDictionary *dic=[NetWorkUtils initParameter:parameters];
    
    NSString *url=[NetWorkUtils initUrl:parameters];
    
    [[NetWorkUtils shareInstance] POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"photo" fileName:@"img1.jpg" mimeType:@"application/octet-stream"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self successCallBack:responseObject callback:callback];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failCallBack:error callback:callback];
    }];
}

///post发送多张图片
+(void)PostPhoto:(id)parameters Tag:(NSString*)tag Array:(NSMutableArray*)array callback:(void (^)(id res))callback
{
    [NetWorkUtils initWithTag:tag];
    
    NSMutableDictionary *dic=[NetWorkUtils initParameter:parameters];
    
    NSString *url=[NetWorkUtils initUrl:parameters];
    
    [[NetWorkUtils shareInstance] POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSInteger i=0; i<[array count]; i++) {
           id obj = [array objectAtIndex:i];
            if ([obj isKindOfClass:[NSData class]]) {
                
                NSData *data=obj;
                // NSLog(@"upload pic length:%u",data.length/1024);
                NSString *name=[NSString stringWithFormat:@"img%ld",(long)(i+1)];
                NSString *filename=[NSString stringWithFormat:@"img%ld.jpg",(long)(i+1)];
                [formData appendPartWithFileData:data name:name fileName:filename mimeType:@"application/octet-stream"];
                
            }
            if ([obj isKindOfClass:[NSString class]]) {
                
                NSData *data=[NSData dataWithContentsOfFile:[array objectAtIndex:i]];
                // NSLog(@"upload pic length:%u",data.length/1024);
                NSString *name=[NSString stringWithFormat:@"img%ld",(long)(i+1)];
                NSString *filename=[NSString stringWithFormat:@"img%ld.jpg",(long)(i+1)];
                [formData appendPartWithFileData:data name:name fileName:filename mimeType:@"application/octet-stream"];
            }
       
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self successCallBack:responseObject callback:callback];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failCallBack:error callback:callback];
    }];
}

///post发送bp
+(void)PostFile:(id)parameters Tag:(NSString*)tag Array:(NSMutableArray*)array callback:(void (^)(id res))callback
{
    [NetWorkUtils initWithTag:tag];
    
    NSMutableDictionary *dic=[NetWorkUtils initParameter:parameters];
    
    NSString *url=[NetWorkUtils initUrl:parameters];
    
    [[NetWorkUtils shareInstance] POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSInteger i=0; i<[array count]; i++) {
                NSData *data=[NSData dataWithContentsOfFile:[array objectAtIndex:i]];
                //NSLog(@"%@",[array objectAtIndex:i]);
                //NSLog(@"upload pic length:%u",data.length/1024);
                NSString *name=[NSString stringWithFormat:@"bp%ld",(long)(i+1)];
                NSString *filename=[NSString stringWithFormat:@"bp%ld.jpg",(long)(i+1)];
                [formData appendPartWithFileData:data name:name fileName:filename mimeType:@"application/octet-stream"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self successCallBack:responseObject callback:callback];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failCallBack:error callback:callback];
    }];
}

+(void)Get:(NSString*)url Tag:(NSString*)tag callback:(void (^)(id res))callback
{
    [[NetWorkUtils shareInstance] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
        NSLog(@"error:%@",error);
        callback(nil);
    }];
}

///初始化请求参数
+(NSMutableDictionary*)initParameter:(id)parameters
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    
    if (parameters!=nil) {
        [dic addEntriesFromDictionary:parameters];
    }
    
    //处理逻辑
    //[dic setObject:[UserDefaults getSession] forKey:@"session"];
    
    return dic;
}

///初始化，取消重复请求
+(void)initWithTag:(NSString*)tag
{
    if (tag) {
        [NetWorkUtils cancelRequestWithTag:tag];
    }
}

///初始化请求地址
+(NSString*)initUrl:(id)suffix
{
    NSString *url=@"";
    if(suffix){
        url=[NSString stringWithFormat:@"%@?c=%@&a=%@",url,[suffix objectForKey:@"c"],[suffix objectForKey:@"a"]];
    }
    return url;
}

///成功时的回调
+(void)successCallBack:(id)responseObject callback:(void (^)(id res))callback
{
    //do somthing when success
    NSLog(@"responseObject:%@",responseObject);
    if (callback) {
//        HttpResult *httpResult=[HttpResult mj_objectWithKeyValues:responseObject];
//        callback(httpResult);
//        if(httpResult.code==9){
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//        }
    }
}

///失败时的回调
+(void)failCallBack:(NSError*)error callback:(void (^)(id res))callback
{
    //do somthing when fail
    if (error.code==-999) {//取消请求是返回的错误代码
        return;
    }
    NSLog(@"error:%@",error);
    if (callback) {
//        HttpResult *httpResult=[[HttpResult alloc]init];
//        httpResult.code=-1;
//        httpResult.result=@"数据加载失败,请稍后再试!";
//        callback(httpResult);
    }
}

+(void)cancelRequestWithTag:(NSString*)tag
{
//    if (tag) {
//        for (NSOperation *operation in [[NetWorkUtils shareInstance].operationQueue operations]) {
//            if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
//                continue;
//            }
//            if ([((AFHTTPRequestOperation *)operation).requestTag isEqualToString:tag]) {
//                [operation cancel];
//            }
//        }
//    }
}

+(void)cancelRequestAll
{
    [[NetWorkUtils shareInstance].operationQueue cancelAllOperations];
}

//----------------------------图片加载-----------------------------------------------//

+(void)setImage:(UIImageView*)view WithUrl:(NSString*)url
{
    [view sd_setImageWithURL:[NSURL URLWithString:url]];
}

+(void)setImage:(UIImageView*)view WithUrl:(NSString*)url Placeholder:(NSString*)imageName
{
    [view sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName]];
}

+(void)setImageDefault1:(UIImageView*)view WithUrl:(NSString*)url
{
    [view sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[CommonUtils ImageWithColor:RGB(238, 238, 238, 1) width:view.frame.size.width height:view.frame.size.height]];
}

+(void)setImage:(UIImageView*)view WithUrl:(NSString*)url Placeholder:(NSString*)imageName Error:(NSString*)errorImage
{
    [view sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [view setImage:[UIImage imageNamed:errorImage]];
        }
    }];
}

+(void)setImageDefault2:(UIImageView*)view WithUrl:(NSString*)url
{
    [view sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[CommonUtils ImageWithColor:RGB(238, 238, 238, 1) width:view.frame.size.width height:view.frame.size.height] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [view setImage:[CommonUtils ImageWithColor:RGB(238, 238, 238, 1) width:view.frame.size.width height:view.frame.size.height]];
        }
    }];
}

+(void)CancelPicDownload
{
    [[SDWebImageManager sharedManager] cancelAll];
}

+(NSString*)picKey:(NSString*)url
{
    return [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
}

+(NSString*)picPath:(NSString*)url
{
    NSString *key=[NetWorkUtils picKey:url];
    return [[SDImageCache sharedImageCache] defaultCachePathForKey:key];
}

+(BOOL)picIsExist:(NSString*)url
{
    NSString *key=[NetWorkUtils picKey:url];
    return [[SDImageCache sharedImageCache] diskImageExistsWithKey:key];
}

+(void)cleanDiskCache
{
    [[SDImageCache sharedImageCache] clearDisk];
}

+(void)cleanMemoryCache
{
    [[SDImageCache sharedImageCache] clearMemory];
}

+(void)checkDiskCacheSize
{
    if (([[SDImageCache sharedImageCache] getSize]/(1024*1024))>500)
    {
        [self cleanDiskCache];
    }
}

+(NSInteger)getCacheSize
{
    return [[SDImageCache sharedImageCache] getSize];
}

@end
