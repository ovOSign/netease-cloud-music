//
//  LMusicToolBar.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/9.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LMusicToolBar.h"
typedef enum {
    LPlayBtnStatePlay,
    LPlayBtnStatePause
} LPlayBtnState;

typedef enum {
    LLoopBtnStateNomal,
    LLoopBtnStateOne,
    LLoopBtnStateshuffle
} LLoopBtnState;

//LPlayButton
@interface LPlayButton : UIButton

@property (nonatomic, assign) LPlayBtnState playState;

@end

@implementation LPlayButton

-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setImage:[UIImage imageNamed:@"cm2_btn_play"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"cm2_btn_pause"] forState:UIControlStateSelected];
        [self setPlayState:LPlayBtnStatePlay];
    }
    return self;
}

- (void)setPlayState:(LPlayBtnState)playState {
    _playState = playState;
    
    switch (playState) {
        case LPlayBtnStatePlay:
            self.selected = NO;
            [self setImage:[UIImage imageNamed:@"cm2_btn_play_prs"] forState:UIControlStateHighlighted];
            break;
        case LPlayBtnStatePause:
            self.selected = YES;
            [self setImage:[UIImage imageNamed:@"cm2_btn_pause_prs"]  forState:UIControlStateSelected | UIControlStateHighlighted];
            break;
    }
}

@end

///LLoopButton
@interface LLoopButton : UIButton

@property (nonatomic, assign) LLoopBtnState playState;

@end

@implementation LLoopButton

-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setImage:[UIImage imageNamed:@"cm2_btn_play"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"cm2_btn_pause"] forState:UIControlStateSelected];
        [self setPlayState:LLoopBtnStateNomal];
    }
    return self;
}

- (void)setPlayState:(LLoopBtnState)playState {
    _playState = playState;
    
    switch (playState) {
        case LLoopBtnStateNomal:
            [self setImage:[UIImage imageNamed:@"cm2_icn_loop"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateHighlighted];
            break;
        case LLoopBtnStateOne:
            [self setImage:[UIImage imageNamed:@"cm2_icn_one"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"cm2_icn_one_prs"] forState:UIControlStateHighlighted];
            break;
        case LLoopBtnStateshuffle:
            [self setImage:[UIImage imageNamed:@"cm2_icn_shuffle"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"cm2_icn_shuffle_prs"] forState:UIControlStateHighlighted];
            break;
    }
}

@end


///LMusicToolBar

@interface LMusicToolBar()

@property (weak, nonatomic) IBOutlet LProgressBar *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet LPlayButton *playOrPauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *loopModelBtn;

@property (nonatomic) NSInteger totalTime;

@end

@implementation LMusicToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
    
    }
    return self;
}

#pragma mark - setter
-(void)setDelegate:(id<LMusicToolBarDelegate>)delegate{
    _delegate = delegate;
    if ([_progressBar isKindOfClass:[LProgressBar class]]) {
        [(LProgressBar *)_progressBar setDelegate:(id<LProgressBarDelegate>)delegate];
    }
}


#pragma mark - Action
- (IBAction)playOrPause:(id)sender {
    LPlayButton *button = sender;
    if (button.playState == LPlayBtnStatePause) {
        button.playState = LPlayBtnStatePlay;
        if ([self.delegate respondsToSelector:@selector(musicToolBarPlayButton:playOnPasue:)]) {
            [self.delegate musicToolBarPlayButton:button playOnPasue:YES];
        }
    }else{
        button.playState = LPlayBtnStatePause;
        if ([self.delegate respondsToSelector:@selector(musicToolBarPlayButton:playOnPasue:)]) {
            [self.delegate musicToolBarPlayButton:button playOnPasue:false];
        }
    }
}
- (IBAction)loopModelAction:(id)sender {
    LLoopButton *button = sender;
    switch (button.playState) {
        case LLoopBtnStateNomal:
            button.playState = LLoopBtnStateOne;
            break;
        case LLoopBtnStateOne:
            button.playState = LLoopBtnStateshuffle;
            break;
        case LLoopBtnStateshuffle:
            button.playState = LLoopBtnStateNomal;
            break;
    }
}

- (IBAction)previous:(UIButton*)sender {
    if ([self.delegate respondsToSelector:@selector(musicToolBarPreviousButton:)]) {
        [self.delegate musicToolBarPreviousButton:sender];
    }
}

- (IBAction)next:(id)sender {
    if ([self.delegate respondsToSelector:@selector(musicToolBarNextButton:)]) {
        [self.delegate musicToolBarNextButton:sender];
    }
}

- (IBAction)src:(id)sender {
    
}


-(void)setPlayOnPause:(BOOL)play{
    if (play == true) {
        _playOrPauseBtn.playState = LPlayBtnStatePlay;
        _selected =true;
    }else{
        _playOrPauseBtn.playState = LPlayBtnStatePause;
        _selected =false;
    }
}

-(void)setCurrentTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)value{
    if (!_progressBar.dragFlag) {
        self.totalTime = totalTime;
        // 当前时长进度progress
        NSInteger proMin = currentTime / 60;//当前秒
        NSInteger proSec = currentTime % 60;//当前分钟
        // duration 总时长
        NSInteger durMin = totalTime / 60;//总秒
        NSInteger durSec = totalTime % 60;//总分钟
        
        [self.progressBar setRatio:value animated:YES];
        self.currentTimeLabel.text       = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
        // 更新总时间
        self.totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];
    }
}
-(void)setCurrentTimeByRadio:(CGFloat)radio{
    NSInteger totalT = [self currentTimeByRadio:radio];
    NSInteger proMin = totalT / 60;//当前秒
    NSInteger proSec = totalT % 60;//当前分钟
    // duration 总时长
    NSInteger durMin = self.totalTime / 60;//总秒
    NSInteger durSec = self.totalTime % 60;//总分钟
    self.currentTimeLabel.text       = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
    // 更新总时间
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];
}

-(NSInteger)currentTimeByRadio:(CGFloat)radio{
    return self.totalTime*radio;
}

@end
