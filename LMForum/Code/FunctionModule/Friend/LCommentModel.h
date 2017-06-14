//
//  LCommentModel.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCommentModel : NSObject

@property (nonatomic, assign) uint64_t statusID; ///< id (number)
@property (nonatomic, strong) NSString *idstr; ///< id (string)
//发布时间
@property (nonatomic, strong) NSDate *createdAt; ///< 发布时间


//用户
@property (nonatomic, assign) uint64_t userID; ///< id (int)
@property (nonatomic, strong) NSString *idString; ///< id (string)
@property (nonatomic, strong) id profileImageURL; ///< 头像 50x50 (FeedList)
@property (nonatomic, assign) BOOL verified; ///< 认证 (大V)
@property (nonatomic, strong) NSString *name; ///< 昵称

@property (nonatomic, strong) NSString *text; ///< 评论

@property (nonatomic, strong) NSString *linkText; ///引用评论


@property (nonatomic, assign) int32_t attitudesCount; ///< 点赞数

@property (nonatomic, assign) int32_t attitudesStatus; ///< 是否已赞 0:没有

@property (nonatomic, strong) NSString *createdTime; ///发布时间

@end


@class LEmoticonGroup;

typedef NS_ENUM(NSUInteger, LEmoticonType) {
    LEmoticonTypeImage = 0, ///< 图片表情
    LEmoticonTypeEmoji = 1, ///< Emoji表情
};

@interface LEmoticon : NSObject
@property (nonatomic, strong) NSString *chs;  ///< 例如 [吃惊]
@property (nonatomic, strong) NSString *cht;  ///< 例如 [吃驚]
@property (nonatomic, strong) NSString *gif;  ///< 例如 d_chijing.gif
@property (nonatomic, strong) NSString *png;  ///< 例如 d_chijing.png
@property (nonatomic, strong) NSString *code; ///< 例如 0x1f60d
@property (nonatomic, assign) LEmoticonType type;
@property (nonatomic, weak) LEmoticonGroup *group;
@end

@interface LEmoticonGroup : NSObject
@property (nonatomic, strong) NSString *groupID; ///< 例如 com.sina.default
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, strong) NSString *nameCN; ///< 例如 浪小花
@property (nonatomic, strong) NSString *nameEN;
@property (nonatomic, strong) NSString *nameTW;
@property (nonatomic, assign) NSInteger displayOnly;
@property (nonatomic, assign) NSInteger groupType;
@property (nonatomic, strong) NSArray<LEmoticon *> *emoticons;
@end
