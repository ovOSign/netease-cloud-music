//
//  LAttentionModel.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/29.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LAttentionModel.h"
@implementation WBPictureMetadata
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cutType" : @"cut_type"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([_type isEqualToString:@"GIF"]) {
        _badgeType = WBPictureBadgeTypeGIF;
    } else {
        if (_width > 0 && (float)_height / _width > 3) {
            _badgeType = WBPictureBadgeTypeLong;
        }
    }
    return YES;
}
@end

@implementation WBPicture
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"picID" : @"pic_id",
             @"keepSize" : @"keep_size",
             @"photoTag" : @"photo_tag",
             @"objectID" : @"object_id",
             @"middlePlus" : @"middleplus"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    WBPictureMetadata *meta = _large ? _large : _largest ? _largest : _original;
    _badgeType = meta.badgeType;
    return YES;
}
@end
@implementation LAttentionModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.playing = false;
        self.linkPicIds = [NSMutableArray array];
    }
    return self;
}

-(void)setShareMusic:(MusicModel *)shareMusic{
    _shareMusic = shareMusic;
//    _songPic = shareMusic.icon;
//    _songName = shareMusic.name;
//    _singerName = shareMusic.singer;
}

@end
