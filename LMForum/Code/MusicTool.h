//
//  MusicTool.h
//  Music
//
//  Created by hanlei on 16/7/21.
//  Copyright © 2016年 hanlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicModel.h"

@class MusicModel;

@interface MusicTool : NSObject

+ (NSArray *)musics;

+ (NSArray *)rectMusics;

+ (MusicModel *)playingMusic;

+ (void)setPlayingMusic:(MusicModel *)playingMusic;

+ (MusicModel *)nextMusic;

+ (MusicModel *)previousMusic;

+ (MusicModel *)findMusicWithName:(NSString*)name;

@end
