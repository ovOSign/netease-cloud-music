//
//  LShareManager.m
//  LMForum
//
//  Created by 梁海军 on 2017/5/12.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LShareManager.h"

@interface LShareManager()

@property(nonatomic, strong)MusicModel *model;

@property(nonatomic, strong)LAttentionModel *attention;


@end

@implementation LShareManager

+ (instancetype)sharedInstance{
    static LShareManager *sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)setCurrentSelectMusic:(MusicModel*)model{
    _model = model;
}

- (MusicModel*)getCurrentSelectMusic{
   return  _model;
}

- (NSString*)getSelectSongName{
    return _model.name;
}


- (LAttentionModel*)createShareModel:(NSString*)text :(NSArray*)pics{
    LAttentionModel *model = [[LAttentionModel alloc] init];
    model.name = [UserManager sharedInstance].user.name;
    model.profileImageURL = [UserManager sharedInstance].user.avatar;
    model.pics = pics;
    model.text = text;
    model.shareMusic = _model;
    model.createdTime = [CommonUtils stringWithTimelineDate:[NSDate date]];
    if (_friendC) {
         LStatusLayout *layout = [[LStatusLayout alloc] initWithStatus:model style:WBLayoutStyleTimeline];
        [_friendC.attentionView.layouts insertObject:layout atIndex:0];
        [_friendC.attentionView.tableView reloadData];
    }
    _attention = model;
    return _attention;
}

- (LAttentionModel*)createPostModel:(NSString*)text : (LAttentionModel *)aModel{
    LAttentionModel *model = [[LAttentionModel alloc] init];
    model.name = [UserManager sharedInstance].user.name;
    model.profileImageURL = [UserManager sharedInstance].user.avatar;
    model.text = text;
    model.retweetedStatus = aModel.retweetedStatus ? aModel.retweetedStatus :aModel;
    model.createdTime = [CommonUtils stringWithTimelineDate:[NSDate date]];
    if (_friendC) {
        LStatusLayout *layout = [[LStatusLayout alloc] initWithStatus:model style:WBLayoutStyleTimeline];
        [_friendC.attentionView.layouts insertObject:layout atIndex:0];
        [_friendC.attentionView.tableView reloadData];
    }
    _attention = model;
    return _attention;
}

- (LAttentionModel*)getShareModel{
    return _attention;
}

- (void)deleteSelect{
    _model = nil;
    _attention = nil;
}

@end
