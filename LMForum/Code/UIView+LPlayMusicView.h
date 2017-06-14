//
//  UIView+LPlayMusicView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/20.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LPlayMusicView)
-(void)playerCurrentTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)value;

-(void)setPlayerVolume:(CGFloat)value;

-(void)setPlayerMusicModel:(MusicModel*)music;

-(void)play;

-(void)pause;
@end
