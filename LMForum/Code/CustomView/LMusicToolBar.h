//
//  LMusicToolBar.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/9.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LProgressBar.h"

@protocol  LMusicToolBarDelegate;

@interface LMusicToolBar : UIView

@property(nonatomic,weak) id<LMusicToolBarDelegate> delegate;

@property(nonatomic) bool selected;

-(void)setPlayOnPause:(BOOL)play;

-(void)setCurrentTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)value;

-(void)setCurrentTimeByRadio:(CGFloat)radio ;

-(NSInteger)currentTimeByRadio:(CGFloat)radio ;

@end


@protocol LMusicToolBarDelegate<NSObject>

- (void)musicToolBarPlayButton:(UIButton *)button playOnPasue:(BOOL)play ;

- (void)musicToolBarPreviousButton:(UIButton *)button;

- (void)musicToolBarNextButton:(UIButton *)button;

@end
