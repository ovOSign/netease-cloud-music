//
//  LAttentionModel.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/29.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
/// 认证方式
typedef NS_ENUM(NSUInteger, LUserVerifyType){
    LUserVerifyTypeNone = 0,     ///< 没有认证
    LUserVerifyTypeStandard,     ///< 个人认证，黄V
    LUserVerifyTypeOrganization, ///< 官方认证，蓝V
    LUserVerifyTypeClub,         ///< 达人认证，红星
};

/// 图片标记
typedef NS_ENUM(NSUInteger, WBPictureBadgeType) {
    WBPictureBadgeTypeNone = 0, ///< 正常图片
    WBPictureBadgeTypeLong,     ///< 长图
    WBPictureBadgeTypeGIF,      ///< GIF
};


/**
 一个图片的元数据
 */
@interface WBPictureMetadata : NSObject
@property (nonatomic, strong) NSURL *url; ///< Full image url
@property (nonatomic, assign) int width; ///< pixel width
@property (nonatomic, assign) int height; ///< pixel height
@property (nonatomic, strong) NSString *type; ///< "WEBP" "JPEG" "GIF"
@property (nonatomic, assign) int cutType; ///< Default:1
@property (nonatomic, assign) WBPictureBadgeType badgeType;
@end


/**
 图片
 */
@interface WBPicture : NSObject
@property (nonatomic, strong) NSString *picID;
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, assign) int photoTag;
@property (nonatomic, assign) BOOL keepSize; ///< YES:固定为方形 NO:原始宽高比
@property (nonatomic, strong) WBPictureMetadata *thumbnail;  ///< w:180
@property (nonatomic, strong) WBPictureMetadata *bmiddle;    ///< w:360 (列表中的缩略图)
@property (nonatomic, strong) WBPictureMetadata *middlePlus; ///< w:480
@property (nonatomic, strong) WBPictureMetadata *large;      ///< w:720 (放大查看)
@property (nonatomic, strong) WBPictureMetadata *largest;    ///<       (查看原图)
@property (nonatomic, strong) WBPictureMetadata *original;   ///<
@property (nonatomic, assign) WBPictureBadgeType badgeType;
@end


@interface LAttentionModel : NSObject

@property (nonatomic, assign) uint64_t statusID; ///< id (number)
@property (nonatomic, strong) NSString *idstr; ///< id (string)
//发布时间
@property (nonatomic, strong) NSDate *createdAt; ///< 发布时间


//用户
@property (nonatomic, assign) uint64_t userID; ///< id (int)
@property (nonatomic, strong) NSString *idString; ///< id (string)
@property (nonatomic, strong) id profileImageURL; ///< 头像 50x50 (FeedList)
@property (nonatomic, assign) BOOL verified; ///< 微博认证 (大V)
@property (nonatomic, strong) NSString *name; ///< 昵称

@property (nonatomic, strong) NSString *text; ///< 正文
@property (nonatomic, strong) NSURL *thumbnailPic; ///< 缩略图
@property (nonatomic, strong) NSURL *bmiddlePic; ///< 中图
@property (nonatomic, strong) NSURL *originalPic; ///< 大图

@property (nonatomic, strong) LAttentionModel *retweetedStatus; ///转发微博

@property (nonatomic, strong) NSArray<NSString *> *picIds;

@property (nonatomic, strong) NSDictionary<NSString *, WBPicture *> *picInfos;

@property (nonatomic, strong) NSArray<id> *pics;

@property (nonatomic, assign) int32_t repostsCount; ///< 转发数
@property (nonatomic, assign) int32_t commentsCount; ///< 评论数
@property (nonatomic, assign) int32_t attitudesCount; ///< 赞数
@property (nonatomic, assign) int32_t attitudesStatus; ///< 是否已赞 0:没有

@property (nonatomic, strong) NSMutableArray<User*> *linkPicIds;


@property (nonatomic, strong) NSString *source; ///< 来自 XXX



//分享歌曲、图片

@property (nonatomic, strong) MusicModel *shareMusic;

@property (nonatomic) BOOL playing;


@property (nonatomic, strong) NSString *createdTime; ///发布时间


//@property (nonatomic, strong) id songPic;
//
//@property (nonatomic, strong) NSString* songName;
//
//@property (nonatomic, strong) NSString* singerName;

@end
