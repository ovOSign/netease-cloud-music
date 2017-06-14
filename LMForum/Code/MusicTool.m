//
//  MusicTool.m
//  Music
//
//  Created by hanlei on 16/7/21.
//  Copyright © 2016年 hanlei. All rights reserved.
//

#import "MusicTool.h"

@implementation MusicTool

static NSArray *_musics;
static NSMutableArray *_rectMusics;
static MusicModel *_playingMusic;

+ (void)initialize
{
    if (_musics == nil) {
        _musics = [MusicModel mj_objectArrayWithFilename:@"Musics.plist"];
        _rectMusics = [NSMutableArray array];
    }
    
    if (_playingMusic == nil) {
        _playingMusic = _musics[1];
        [_rectMusics addObject:_musics[1]];
    }
}

+ (NSArray *)musics
{
    return _musics;
}

+ (NSArray *)rectMusics
{
    return _rectMusics;
}
+ (MusicModel *)playingMusic
{
    return _playingMusic;
}

+ (void)setPlayingMusic:(MusicModel *)playingMusic
{
    if (![_rectMusics containsObject:playingMusic]) {
         [_rectMusics addObject:playingMusic];
    }
    _playingMusic = playingMusic;
}

+ (MusicModel *)nextMusic
{
    // 1.拿到当前播放歌词下标值
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    
    // 2.取出下一首
    NSInteger nextIndex = ++currentIndex;
    if (nextIndex >= _musics.count) {
        nextIndex = 0;
    }
    MusicModel *nextMusic = _musics[nextIndex];
    
    return nextMusic;
}

+ (MusicModel *)previousMusic
{
    // 1.拿到当前播放歌词下标值
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    
    // 2.取出下一首
    NSInteger previousIndex = --currentIndex;
    if (previousIndex < 0) {
        previousIndex = _musics.count - 1;
    }
    MusicModel *previousMusic = _musics[previousIndex];
    
    return previousMusic;
}

+ (MusicModel *)findMusicWithName:(NSString*)name{
    MusicModel *music;
    for (MusicModel *mm in _musics) {
        if ([mm.name isEqualToString:name]) {
            music = mm;
        }
    }
    return music;
}

@end
