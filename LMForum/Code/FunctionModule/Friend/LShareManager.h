//
//  LShareManager.h
//  LMForum
//
//  Created by 梁海军 on 2017/5/12.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendController.h"
@interface LShareManager : NSObject

@property (nonatomic, strong) FriendController *friendC;

+ (instancetype)sharedInstance;

- (MusicModel*)getCurrentSelectMusic;

- (void)setCurrentSelectMusic:(MusicModel*)model;

- (NSString*)getSelectSongName;

- (void)deleteSelect;

- (LAttentionModel*)createShareModel:(NSString*)text :(NSArray*)pics;

- (LAttentionModel*)createPostModel:(NSString*)text : (LAttentionModel *)aModel;

- (LAttentionModel*)getShareModel;

@end
