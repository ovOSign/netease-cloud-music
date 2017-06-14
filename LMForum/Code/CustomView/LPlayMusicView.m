//
//  LPlayMusicView.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/6.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LPlayMusicView.h"
#import "LScrolLabel.h"
#import "LMusicToolBar.h"
#import "LDiscMainView.h"
#import "LScrollDiscView.h"
#import "UIImage+BoxBlur.h"
#import "UIView+LPlayMusicView.h"
#import "LLrcMainView.h"
#import "LVolumeBar.h"
@interface LPlayMusicView()<UIGestureRecognizerDelegate,LMusicToolBarDelegate,
                            LDiscMainViewDelegate,LScrollDiscViewDelegate,
                            LProgressBarDelegate,LLrcMainViewDelegate,
                            LLrcScrollViewDelegate,LVolumeBarDelegate>

@property(nonatomic, strong)UINavigationBar *navigationBar;

@property(nonatomic, strong)UIImageView *bgImageView;

@property(nonatomic, strong)UIImageView *maskImageView;

@property(nonatomic, strong)LDiscMainView *disMainView;

@property(nonatomic, strong)LLrcMainView *lrcMainView;

@property(nonatomic, strong)LScrolLabel *barLabel;

@property(nonatomic, strong)LMusicToolBar *toolBar;

@property(nonatomic, strong)UINavigationItem *navigationItem;

@property(nonatomic, strong)LAVPlayer *player;

@property(nonatomic)PlayMusicState playMusicState;



@end

#define AnimationDuration 0.5

@implementation LPlayMusicView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.navigationBar];
        [self addSubview:self.toolBar];
        [self addSubview:self.disMainView];
        [self addSubview:self.lrcMainView];
        UIImage *bgImage = [self _bgImage];
        _bgImageView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointMake(0, 0),bgImage.size}];
        [_bgImageView setImage:bgImage];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds=YES;
        [self insertSubview:_bgImageView atIndex:0];
        
        UIImage *maskImag = [self _maskImage];
        _maskImageView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointMake(0, 0),maskImag.size}];
        [_maskImageView setImage:maskImag];
        [self insertSubview:_maskImageView atIndex:1];
        
        //左滑
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePan:)];
        panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:panGestureRecognizer];
        
        
        //点击discMain
        UITapGestureRecognizer *discTapGesture = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(discHandleTap:)];
        _disMainView.userInteractionEnabled = YES;
        [_disMainView addGestureRecognizer:discTapGesture];
        
        //点击discMain
        UITapGestureRecognizer *lrcTapGesture = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(lrcHandleTap:)];
        _lrcMainView.userInteractionEnabled = YES;
        [_lrcMainView addGestureRecognizer:lrcTapGesture];
        
        
        self.playMusicState = PlayMusicStateInit;
        
        self.navigationBar.layer.masksToBounds=YES;
        
        __weak __typeof(self)wself = self;
        MusicModel *music = [self.player currentMusic];
        if (!music) {
            music = [self.player loadSongWithMenu];
        }else{
            [_disMainView putNeedleAnimation:true];
            //初始化的时候特别注意
            _disMainView.scrollDiscView.animationBool = true;
            [_toolBar setPlayOnPause:false];
            self.playMusicState = PlayMusicStatePlay;
        }
        [_disMainView setSongImage:music.icon completed:^(UIImage *image) {
            [wself.bgImageView setImage:[[image downsampleImage] drn_boxblurImageWithBlur:3 withTintColor:RGB(100, 100, 100, 0.8)]];
            
        }];
        [_lrcMainView reloadLrcArray:[self.player lrcWithName:music.lrcname]];
        [_barLabel setSongName:music.name singer:music.singer];
        
    }
    return self;
}

-(UINavigationBar*)navigationBar{
    if (!_navigationBar) {
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        [_navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        _navigationBar.items = @[self.navigationItem];
    }
    return _navigationBar;
}

-(UINavigationItem*)navigationItem{
    if (!_navigationItem) {
        _navigationItem = [[UINavigationItem alloc]init];
        //backButton
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_back"] forState:UIControlStateNormal];
        backButton.frame = CGRectMake(0, 0, 50, 30);
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView *leftView = [[UIView alloc] init];
        leftView.bounds = CGRectMake(0, 0, 50, 30);
        [leftView addSubview:backButton];
        UIBarButtonItem  *backBtnItem =  [[UIBarButtonItem alloc]initWithCustomView:leftView];
        _navigationItem.leftBarButtonItem = backBtnItem;

        //shareButton
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_share"] forState:UIControlStateNormal];
        shareButton.bounds = CGRectMake(0, 0, 50, 30);
        [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem  *shareBtnItem =  [[UIBarButtonItem alloc]initWithCustomView:shareButton];
        _navigationItem.rightBarButtonItem = shareBtnItem;
        //titleview
        _navigationItem.titleView = self.barLabel;
        
    }
    return _navigationItem;
}

-(LScrolLabel*)barLabel{
    if (!_barLabel) {
        _barLabel = [[LScrolLabel alloc] initWithFrame:CGRectMake(0, 0, _navigationBar.frame.size.width-    104, 30)];
    }
    return _barLabel;
}

-(LDiscMainView*)disMainView{
    if (!_disMainView) {
        CGFloat height = ceilf(self.frame.size.height-64-_toolBar.frame.size.height);
        _disMainView = [[LDiscMainView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navigationBar.frame),self.frame.size.width, height)];
        _disMainView.delegate = self;
    }
    return _disMainView;
}

-(LLrcMainView*)lrcMainView{
    if (!_lrcMainView) {
        CGFloat height = ceilf(self.frame.size.height-64-_toolBar.frame.size.height);
        _lrcMainView = [[LLrcMainView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navigationBar.frame),self.frame.size.width, height)];
        _lrcMainView.delegate = self;
        [_lrcMainView reloadLrcArray:[self.player lrcWithName:@"309769.lrc"]];
        [_lrcMainView setVolumeValue:[self.player getSystemVolume]];
        _lrcMainView.alpha = 0;
    }
    return _lrcMainView;
}

-(LMusicToolBar*)toolBar{
    if (!_toolBar) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LMusicToolBar" owner:nil options:nil];
        _toolBar = [array objectAtIndex:0];
        _toolBar.delegate = self;
        CGFloat height = self.frame.size.width*140/400;
        _toolBar.frame = CGRectMake(0, self.frame.size.height-height, self.frame.size.width,height);
    }
    return _toolBar;
}


-(LAVPlayer*)player{
    if (!_player) {
        _player = [LAVPlayer sharedInstance];
        _player.controlView = self;
    }
    return _player;
}

#pragma mark - Action
-(void)backAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(playMusicView:returnToPrevious:)]) {
        [self.delegate playMusicView:self returnToPrevious:YES];
        //重置
       // [self resetScroll];
    }
}

-(void)shareAction:(UIButton *)button{
    
}

-(void) discHandleTap:(UIPanGestureRecognizer*) recognizer{
    
    [UIView beginAnimations:@"hideDisc" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:AnimationDuration];
    _disMainView.alpha = 0.0;
    _maskImageView.alpha = 0.0;
    _lrcMainView.alpha = 1.0;
    [UIView commitAnimations];
}

-(void) lrcHandleTap:(UIPanGestureRecognizer*) recognizer{
    
    [UIView beginAnimations:@"hideLrc" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:AnimationDuration];
    _disMainView.alpha = 1.0;
    _maskImageView.alpha = 1.0;
    _lrcMainView.alpha = 0.0;
    [UIView commitAnimations];
}



-(void) handlePan:(UIPanGestureRecognizer*) recognizer{
    CGPoint translatedPoint = [recognizer translationInView:self.superview];
    if ([self.delegate respondsToSelector:@selector(playMusicView:translateX:)]) {
        [self.delegate playMusicView:self translateX:translatedPoint.x];
    }
    if(recognizer.state == UIGestureRecognizerStateEnded){
        if ([self.delegate respondsToSelector:@selector(playMusicView:translateEnd:)]) {
            [self.delegate playMusicView:self translateEnd:true];
        }
    }
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint tapPoint = [gestureRecognizer locationInView:self];
    if (tapPoint.x>=0 && tapPoint.x<=drogblank) {
       return true;
    }else{
       return false;
    }
}
#pragma mark - public
-(void)startScrollLabel{
    [self.barLabel startScroll];
}

-(void)resetScroll{
   [self.barLabel resetScroll];
}

#pragma mark - private

-(UIImage*)_maskImage{
    NSInteger deivce  = [CommonUtils deivceType];
    UIImage *maskImag;
    if (deivce == 0) {
        maskImag = [UIImage imageNamed:@"cm2_play_disc_mask-568h"];
    }else if(deivce ==1 ){
        maskImag = [UIImage imageNamed:@"cm2_play_disc_mask-ip6"];
    }else if(deivce ==2 ){
        maskImag = [UIImage imageNamed:@"cm2_play_disc_mask"];
    }
    return maskImag;
}

-(UIImage*)_bgImage{
    NSInteger deivce  = [CommonUtils deivceType];
    UIImage *bgImage;
    if (deivce == 0) {
        bgImage = [UIImage imageNamed:@"cm2_default_play_bg-568h.jpg"];
    }else if(deivce ==1 ){
        bgImage = [UIImage imageNamed:@"cm2_default_play_bg-ip6.jpg"];
    }else if(deivce ==2 ){
        bgImage = [UIImage imageNamed:@"cm2_default_play_bg.jpg"];
    }
    return bgImage;
}

#pragma mark - LMusicToolBarDelegate
//播放暂停按钮
-(void)musicToolBarPlayButton:(UIButton *)button playOnPasue:(BOOL)play{
    if (play == true) {
        [_player pause];        
    }else{
        [_player play];
    }
}

- (void)musicToolBarPreviousButton:(UIButton *)button{
    [_disMainView releaseNeedleAnimation:true];
    [_disMainView.scrollDiscView  previous];
}

- (void)musicToolBarNextButton:(UIButton *)button{
    [_disMainView releaseNeedleAnimation:true];
    [_disMainView.scrollDiscView  next];
}


#pragma mark - LScrollDiscViewDelegate
- (void)scrollDiscViewDidEndDecelerating:(LScrollDiscView *)scrollDiscView state:(LDiscState)state {
    switch (state) {
        case LDiscStateDefault:
            [self normalDragEnd];
            break;
        case LDiscStateLeft:
           [self leftDragEnd];
            break;
        case LDiscStateRight:
            [self rightDragEnd];
           break;
        default:
            break;
    }
    
}
-(void)scrollDiscViewDidScroll:(LScrollDiscView *)scrollDiscView{
    bool put = _disMainView.puted;
    [_disMainView releaseNeedleAnimation:true];
    _disMainView.puted = put;
    BOOL animation = _disMainView.scrollDiscView.animationing;
    [_disMainView.scrollDiscView  stopRotationAnimation];
    _disMainView.scrollDiscView.animationing = animation;
}


#pragma mark - 分页
//修改当前时间和更改进度条
-(void)playerCurrentTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)value{
    [_toolBar setCurrentTime:currentTime totalTime:totalTime sliderValue:value];
    [_lrcMainView.lrcScrollView setCurrentTime:currentTime];
    if(value == 1){
        [_disMainView.scrollDiscView  startRotationAnimation];
        [self _nextMusic];
    }
}

-(void)setPlayerVolume:(CGFloat)value{
    [_lrcMainView setVolumeValueByRatio:value animated:YES];
}

-(void)setPlayerMusicModel:(MusicModel*)music{
    [_disMainView.scrollDiscView startRotationAnimation];
     __weak __typeof(self)wself = self;
    [_disMainView setSongImage:music.icon completed:^(UIImage *image) {
        [wself.bgImageView setImage:[[image downsampleImage] drn_boxblurImageWithBlur:3 withTintColor:RGB(100, 100, 100, 0.8)]];
        
    }];
    [_lrcMainView reloadLrcArray:[self.player lrcWithName:music.lrcname]];
    [_barLabel setSongName:music.name singer:music.singer];
    [_disMainView putNeedleAnimation:true];
    [_toolBar setPlayOnPause:false];
    self.playMusicState = PlayMusicStatePlay;
}

#pragma mark - LProgressBarDelegate
- (void)progressBar:(LProgressBar *)progressBar didSidler:(CGFloat)ratio{
    if (progressBar.dragFlag) {
        dispatch_main_async_safe(^{
          [_toolBar setCurrentTimeByRadio:ratio];
        });
    }
}
- (void)progressBarEndDrag:(LProgressBar *)progressBar didSidler:(CGFloat)ratio{
    [_player seekToTime:[_toolBar currentTimeByRadio:ratio] play:(self.playMusicState == PlayMusicStatePlay ? true:false) completionHandler:nil];
    
}

#pragma mark - LLrcScrollViewDelegate
-(void)lrcScrollView:(LLrcScrollView *)lrcScroll currentIndicateTime:(NSTimeInterval)time{
    [_player seekToTime:time play:(self.playMusicState == PlayMusicStatePlay ? true:false) completionHandler:nil];
}


#pragma mark - LVolumeBarDelegate
-(void)volumeBar:(LVolumeBar *)volumeBar didSidler:(CGFloat)ratio{
    [_player setSystemVolume:ratio];
}


//还原
-(void)normalDragEnd{
    if (_disMainView.puted) {
      [_disMainView putNeedleAnimation:true];
    }
    [_toolBar setPlayOnPause:_toolBar.selected];
    if (_disMainView.scrollDiscView.animationing) {
     [_disMainView.scrollDiscView resumeRotationAnimation];
    }
    
}
//左
-(void)leftDragEnd{
    self.playMusicState = PlayMusicStateChange;
    [self _previousMusic];
}
//右
-(void)rightDragEnd{
    self.playMusicState = PlayMusicStateChange;
    [self _nextMusic];
}






#pragma mark 切歌

-(void)_nextMusic{
    __weak __typeof(self)wself = self;
    MusicModel *music = [self.player next];
    [self.player play];
    [_disMainView setSongImage:music.icon completed:^(UIImage *image) {
        [wself.bgImageView setImage:[[image downsampleImage] drn_boxblurImageWithBlur:3 withTintColor:RGB(100, 100, 100, 0.8)]];
        
    }];
    [_lrcMainView reloadLrcArray:[self.player lrcWithName:music.lrcname]];
    [_barLabel setSongName:music.name singer:music.singer];
}


-(void)_previousMusic{
    __weak __typeof(self)wself = self;
    MusicModel *music = [self.player previous];
    [self.player play];
    [_disMainView setSongImage:music.icon completed:^(UIImage *image) {
        [wself.bgImageView setImage:[[image downsampleImage] drn_boxblurImageWithBlur:3 withTintColor:RGB(100, 100, 100, 0.8)]];
        
    }];
    [_lrcMainView reloadLrcArray:[self.player lrcWithName:music.lrcname]];
    [_barLabel setSongName:music.name singer:music.singer];
}

//控制动画
-(void)play{
    [_toolBar setPlayOnPause:false];
    [_disMainView putNeedleAnimation:true];
    if(self.playMusicState == PlayMusicStateInit || self.playMusicState == PlayMusicStateChange)[_disMainView.scrollDiscView  startRotationAnimation];
    else [_disMainView.scrollDiscView  resumeRotationAnimation];
    self.playMusicState = PlayMusicStatePlay;
}

-(void)pause{
    [_toolBar setPlayOnPause:true];
    [_disMainView releaseNeedleAnimation:true];
    [_disMainView.scrollDiscView  stopRotationAnimation];
    self.playMusicState = PlayMusicStatePause;
}

@end
