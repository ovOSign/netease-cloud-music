//
//  LAVPlayer.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/11.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LAVPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIView+LPlayMusicView.h"
#import "LMusicLrcModel.h"
#import "MusicTool.h"
@interface LAVPlayer()

@property (nonatomic, strong) AVPlayer               *player;

@property (nonatomic, strong) AVPlayerItem           *playerItem;

@property (nonatomic, strong) AVURLAsset             *urlAsset;

@property (nonatomic, strong) id                     timeObserve;

/** 滑杆 */
@property (nonatomic, strong) UISlider               *volumeViewSlider;

@end

@implementation LAVPlayer

+(instancetype)sharedInstance{
    static LAVPlayer *sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[self alloc]init];
    });
    return sharedInstance;
}

-(void)playSongWithUrl:(NSURL *)songUrl{
    [self loadSongWithUrl:songUrl];
    [self.player play];
}


-(void)loadSongWithUrl:(NSURL *)songUrl{
    self.urlAsset = [AVURLAsset assetWithURL:songUrl];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self createTimer];
    [self configureVolume];
}

-(MusicModel *)loadSongWithMenu{
    self.currentMusic = [MusicTool playingMusic];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:self.currentMusic.filename withExtension:nil];
    [self loadSongWithUrl:fileUrl];
    return  self.currentMusic;
}


-(MusicModel *)playSongWithMenu{
    if (!self.currentMusic) {
        self.currentMusic = [MusicTool playingMusic];
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:self.currentMusic.filename withExtension:nil];
        [self loadSongWithUrl:fileUrl];
    }
    [self.player play];
    return  self.currentMusic;
}

- (void)createTimer {
    __weak typeof(self) weakSelf = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:nil usingBlock:^(CMTime time){
        AVPlayerItem *currentItem = weakSelf.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            NSInteger currentTime = (NSInteger)CMTimeGetSeconds([currentItem currentTime]);
            CGFloat totalTime     = (CGFloat)currentItem.duration.value / currentItem.duration.timescale;
            CGFloat value         = CMTimeGetSeconds([currentItem currentTime]) / totalTime;
            [weakSelf.controlView playerCurrentTime:currentTime totalTime:totalTime sliderValue:value];
            
        }
        if (self.player.rate == 1 ) {
            if (![weakSelf.playStatBtn.imageView isAnimating]) {
                    [weakSelf.playStatBtn.imageView startAnimating];
                }
        }else{
            if ([weakSelf.playStatBtn.imageView isAnimating]) {
                [weakSelf.playStatBtn.imageView stopAnimating];
            }
        }

    }];
   
}

-(void)seekToTime:(NSInteger)dragedSeconds play:(BOOL)play completionHandler:(void (^)(BOOL finished))completionHandler{
        if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
            // seekTime:completionHandler:不能精确定位
            // 如果需要精确定位，可以使用seekToTime:toleranceBefore:toleranceAfter:completionHandler:
            [self.player pause];
            CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1); //kCMTimeZero
            __weak typeof(self) weakSelf = self;
            [self.player seekToTime:dragedCMTime toleranceBefore:CMTimeMake(1,1) toleranceAfter:CMTimeMake(1,1) completionHandler:^(BOOL finished){
                if(play){
                 [weakSelf.player play];
                }
                // 视频跳转回调
                if (completionHandler) { completionHandler(finished); }
            }];
        }
    }

/**
 *  播放
 */
- (void)play {
    [_player play];
    if (self.listStatBtn) {
        self.listStatBtn.selected = true;
    }
    if(self.controlView)[self.controlView play];
}

- (void)pause {
    [_player pause];
    if (self.listStatBtn) {
        self.listStatBtn.selected = false;
    }
    if(self.controlView)[self.controlView pause];
}

- (Boolean)isPlaying{
    
    return self.player.rate==1;
}

- (MusicModel *)previous{
    self.currentMusic = [MusicTool previousMusic];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:self.currentMusic.filename withExtension:nil];
    [self loadSongWithUrl:fileUrl];
    [MusicTool setPlayingMusic:self.currentMusic];
    if (self.listStatBtn) {
        self.listStatBtn.selected = false;
        self.listStatBtn = nil;
    }
    return self.currentMusic;
}

- (MusicModel *)next{
    self.currentMusic = [MusicTool nextMusic];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:self.currentMusic.filename withExtension:nil];
    [self loadSongWithUrl:fileUrl];
    [MusicTool setPlayingMusic:self.currentMusic];
    if (self.listStatBtn) {
        self.listStatBtn.selected = false;
        self.listStatBtn = nil;
    }
    return self.currentMusic;
}

- (void)playSongWithSongName:(NSString*)songName listButton:(UIButton*)button{
    if (self.listStatBtn) {
        self.listStatBtn.selected = false;
    }
    self.listStatBtn = button;
    MusicModel* music = [MusicTool findMusicWithName:songName];
    if (music) {
        self.currentMusic = music;
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:self.currentMusic.filename withExtension:nil];
        [self loadSongWithUrl:fileUrl];
        [MusicTool setPlayingMusic:self.currentMusic];
        if(self.controlView)[self.controlView setPlayerMusicModel:self.currentMusic];
        [self play];
    }
}

- (void)playSongWithSongName:(NSString*)songName{
    MusicModel* music = [MusicTool findMusicWithName:songName];
    if (music) {
        self.currentMusic = music;
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:self.currentMusic.filename withExtension:nil];
        [self loadSongWithUrl:fileUrl];
        [MusicTool setPlayingMusic:self.currentMusic];
        if(self.controlView)[self.controlView setPlayerMusicModel:self.currentMusic];
        [self play];
    }
}


- (NSArray *)getRectPlayArray{
    return [MusicTool rectMusics];
}

- (void)setCurrentMusic:(MusicModel *)currentMusic{
    _currentMusic = currentMusic;
    _currentMusic.count += 1;
}


- (NSArray* )getRectPlayMoreArry{
    NSArray *rects = [MusicTool rectMusics];
//    NSComparator cmptr = ^(MusicModel *obj1, MusicModel *obj2){
//        if (obj1.count > obj2.count ) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        
//        if (obj1.count < obj2.count) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    };
//    NSArray *sorArray = [rects sortedArrayUsingComparator:cmptr];
//    
//    return sorArray;
    NSComparator cmptr = ^(MusicModel *obj1, MusicModel *obj2){
        if (obj1.count > obj2.count) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if (obj1.count < obj2.count) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    NSArray *sorArray = [rects sortedArrayUsingComparator:cmptr];
    return sorArray;
}




///-----------------------歌词----------------------

- (NSMutableArray *)lrcWithName:(NSString *)lrcName{
    //1.歌词文件路径
    NSString *lrcPath = [[NSBundle mainBundle]pathForResource:lrcName ofType:nil];
    //2.读取歌词
    NSString *lrcString = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    //3.拿到歌词数组
    NSArray *lrcArray = [lrcString componentsSeparatedByString:@"\n"];
    //4.遍历
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *lrcStr in lrcArray) {
        //过滤
        if ([lrcStr hasPrefix:@"[ti:"] || [lrcStr hasPrefix:@"[ar:"] || [lrcStr hasPrefix:@"[al:"] || ![lrcStr hasPrefix:@"["]) {
            continue;
        }
        LMusicLrcModel *lrcModel = [LMusicLrcModel lrcLineString:lrcStr];
        [tempArray addObject:lrcModel];
    }
    
    return tempArray;
}



/**
 **
 *  获取系统音量
 */
- (void)configureVolume {
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    _volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    
    // 使用这个category的应用不会随着手机静音键打开而静音，可在手机静音下播放声音
    NSError *setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance]
                    setCategory: AVAudioSessionCategoryPlayback
                    error: &setCategoryError];
    
    if (!success) { /* handle the error in setCategoryError */ }
    
    // 监听耳机插入和拔掉通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];
    
     NSError *error;
     [[AVAudioSession sharedInstance] setActive:YES error:&error];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];

    
}

/**
 *  耳机插入、拔出事件
 */
- (void)audioRouteChangeListenerCallback:(NSNotification*)notification {
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // 耳机插入
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
        {
            // 耳机拔掉
            // 拔掉耳机继续播放
            [self play];
        }
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
            break;
    }
}


-(void)volumeChanged:(NSNotification *)notification{
    float volume =[[[notification userInfo]objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"]
     floatValue];
    [self.controlView setPlayerVolume:volume];
}


-(CGFloat)getSystemVolume{
    return [[AVAudioSession sharedInstance] outputVolume];
}

-(void)setSystemVolume:(CGFloat )systemVolume{
    _volumeViewSlider.value = systemVolume;
    
}

-(void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
