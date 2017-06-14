//
//  NetWorkUtils.h
//  App
//
//  Created by Yu on 15/12/1.
//  Copyright © 2015年 HangZhou QiYi Technology Co.,Ltd. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

@interface NetWorkUtils : NSObject


//---------------------------网络请求------------------------------------------------//

//检测网络状态
+(void)netWorkStatus:(void (^)(AFNetworkReachabilityStatus code))callback;

///发送get请求
+(void)GetRequest:(NSString*)parameters Tag:(NSString*)tag callback:(void (^)(id res))callback;

///发送post请求
+(void)PostRequest:(id)parameters Tag:(NSString*)tag callback:(void (^)(id res))callback;

+(void)PostRequest:(NSString*)url  parameter:(NSMutableDictionary*)dic Tag:(NSString*)tag callback:(void (^)(id res))callback;

///post发送图片
+(void)PostPhoto:(id)parameters Tag:(NSString*)tag data:(NSData*)data callback:(void (^)(id res))callback;

///post发送多张图片
+(void)PostPhoto:(id)parameters Tag:(NSString*)tag Array:(NSMutableArray*)array callback:(void (^)(id res))callback;

///post发送bp
+(void)PostFile:(id)parameters Tag:(NSString*)tag Array:(NSMutableArray*)array callback:(void (^)(id res))callback;

///发送get请求
+(void)Get:(NSString*)url Tag:(NSString*)tag callback:(void (^)(id res))callback;

///------------------------------
///(取消请求可能失败，因为采用遍历，存在时间差)
///------------------------------
///根据tag取消请求(取消后会返回一个错误，注意和其他错误区分)
+(void)cancelRequestWithTag:(NSString*)tag;

///取消所有请求(取消后会返回一个错误，注意和其他错误区分)
+(void)cancelRequestAll;

/*
 *
 *可以直接用sdwebimage方法
 *
 *
 */
//----------------------------图片加载-----------------------------------------------//

///加载网络图片
+(void)setImage:(UIImageView*)view WithUrl:(NSString*)url;

///加载网络图片  placeholder
+(void)setImage:(UIImageView*)view WithUrl:(NSString*)url Placeholder:(NSString*)imageName;

///加载网络图片  默认placeholder
+(void)setImageDefault1:(UIImageView*)view WithUrl:(NSString*)url;

///加载网络图片  placeholder Error
+(void)setImage:(UIImageView*)view WithUrl:(NSString*)url Placeholder:(NSString*)imageName Error:(NSString*)errorImage;

///加载网络图片  默认placeholder  默认Error
+(void)setImageDefault2:(UIImageView*)view WithUrl:(NSString*)url;

///取消图片下载
+(void)CancelPicDownload;

///获取图片disk缓存的key
+(NSString*)picKey:(NSString*)url;

///获取图片disk缓存的path
+(NSString*)picPath:(NSString*)url;

///图片disk缓存是否存在
+(BOOL)picIsExist:(NSString*)url;

///清空硬盘缓存
+(void)cleanDiskCache;

///清空内存缓存
+(void)cleanMemoryCache;

///检查硬盘缓存大小(超过500M就清空)
+(void)checkDiskCacheSize;

///获取缓存大小
+(NSInteger)getCacheSize;

@end
