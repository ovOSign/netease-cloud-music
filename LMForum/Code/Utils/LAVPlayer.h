//
//  LAVPlayer.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/11.
//  Copyright © 2017年 lhj. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>

#import "MusicModel.h"
@interface LAVPlayer : NSObject

@property (nonatomic, strong) UIView                 *controlView;

@property (nonatomic, strong) UIButton               *playStatBtn;

@property (nonatomic, strong) UIButton               *listStatBtn;

@property (nonatomic, strong) MusicModel             *currentMusic;

+(instancetype)sharedInstance;

-(void)playSongWithUrl:(NSURL *)songUrl;

-(void)loadSongWithUrl:(NSURL *)songUrl;

-(MusicModel *)loadSongWithMenu;
    
-(MusicModel*)playSongWithMenu;


- (void)seekToTime:(NSInteger)dragedSeconds play:(BOOL)play completionHandler:(void (^)(BOOL finished))completionHandler;

/**
 *  加载歌词
 */
- (NSMutableArray *)lrcWithName:(NSString *)lrcName;


///---------------------------------------------------

/**
 *  播放
 */
- (void)play;

/**
 * 暂停
 */
- (void)pause;


- (MusicModel *)previous;

- (MusicModel *)next;


- (void)playSongWithSongName:(NSString*)songName listButton:(UIButton*)button;

- (void)playSongWithSongName:(NSString*)songName;


- (NSArray *)getRectPlayArray;

- (NSArray* )getRectPlayMoreArry;


- (Boolean)isPlaying;


-(CGFloat)getSystemVolume;

-(void)setSystemVolume:(CGFloat )systemVolume;





//
///**
// *  获取正在播放的时间点
// *
// *  @return double的一个时间点
// */
//- (double)currentTime;
//
///**
// * 重置播放器
// */
//- (void )resetLAVPlayer;

@end

