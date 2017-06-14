//
//  LVolumeBar.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LVolumeBar.h"
@interface LVolumeBar(){
    BOOL loadFirst;
}

@property(nonatomic, strong)UIButton *playButton;

@property(nonatomic, strong)UIImageView *backgroundView;

@property(nonatomic, strong)UIImageView *currentView;

@property(nonatomic)CGFloat value;

@end

#define padding 10

#define stretchImgFromMiddle(img)	[(img) stretchableImageWithLeftCapWidth:(img).size.width / 2 topCapHeight:(img).size.height / 2]


@implementation LVolumeBar

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self addSubview:self.backgroundView];

        //playButton不能加在imageview上，否则点击事件失效
        [self addSubview:self.playButton];
        
        [self addSubview:self.currentView];
        
        //[self setupView];
        loadFirst = true;

    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundView];
        
        //playButton不能加在imageview上，否则点击事件失效
        [self addSubview:self.playButton];
        
        [self addSubview:self.currentView];
        
        
        [self setupView];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    if (loadFirst == true) {
        [self setupView];
        loadFirst = false;
    }
    
}

-(void)setupView{
    
    //_backgroundView
    self.backgroundView.frame = CGRectMake(padding, (self.frame.size.height-_backgroundView.image.size.height)*.5, self.frame.size.width-2*padding, _backgroundView.image.size.height);
    
    //playButton
    CGSize btnSize = [self playButtonSize];
    self.playButton.frame = CGRectMake((CGRectGetWidth(self.bounds)- 2*padding)*self.value-btnSize.width*.5+self.backgroundView.frame.origin.x, (self.frame.size.height-btnSize.height)*.5, btnSize.width, btnSize.height);
    
    //currentView
    self.currentView.frame = CGRectMake(_backgroundView.frame.origin.x, (self.frame.size.height-_currentView.image.size.height)*.5, self.playButton.center.x- padding, _currentView.image.size.height);
    
    [self bringSubviewToFront:self.playButton];
    
}


-(UIImageView*)currentView{
    if (!_currentView) {
        UIImage *image = [UIImage imageNamed:@"cm2_playbar_ready"];
        _currentView = [[UIImageView alloc] initWithImage:stretchImgFromMiddle(image)];
    }
    return _currentView;
}


-(UIButton*)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"cm2_vol_btn"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"cm2_vol_btn"] forState:UIControlStateHighlighted];
        [_playButton addTarget:self action:@selector(buttonDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_playButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
        
    }
    return _playButton;
}

-(UIImageView*)backgroundView{
    if (!_backgroundView) {
        UIImage *image = [UIImage imageNamed:@"cm2_playbar_bg"];
        _backgroundView = [[UIImageView alloc] initWithImage:stretchImgFromMiddle(image)];
    }
    return _backgroundView;
}

-(CGSize)playButtonSize{
    return CGSizeMake(self.frame.size.height, self.frame.size.height);
}

- (IBAction)buttonDrag:(UIButton *)button withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    
    button.center = CGPointMake(MIN(CGRectGetWidth(self.bounds) - padding, MAX(padding, button.center.x + (point.x - lastPoint.x))),
                                button.center.y);
    CGFloat ratio =( button.center.x - padding)/ (CGRectGetWidth(self.bounds)- 2*padding);
    if (ratio == 0) {
        [self.volImagew setImage:[UIImage imageNamed:@"cm2_fm_vol_speaker_silent"]];
    }else{
        [self.volImagew setImage:[UIImage imageNamed:@"cm2_fm_vol_speaker"]];
    }
    if ([self.delegate respondsToSelector:@selector(volumeBar:didSidler:)]) {
        [self.delegate volumeBar:self didSidler:ratio];
    }
    
    
    [self updateCurrentView];

}
- (IBAction)buttonAction:(UIButton *)button{

}

-(void)updateCurrentView {
    CGRect currentViewFrame = CGRectMake(self.currentView.frame.origin.x,
                                         self.currentView.frame.origin.y,
                                         self.playButton.center.x- padding ,
                                         self.currentView.bounds.size.height);
    self.currentView.frame = currentViewFrame;
}

#pragma mark - public
- (void)setRatio:(float)ratio animated:(BOOL)animated{
    if (ratio == 0) {
        [self.volImagew setImage:[UIImage imageNamed:@"cm2_fm_vol_speaker_silent"]];
    }else{
        [self.volImagew setImage:[UIImage imageNamed:@"cm2_fm_vol_speaker"]];
    }
    CGFloat centerX = (CGRectGetWidth(self.bounds)- 2*padding)*ratio+CGRectGetMinX(self.backgroundView.frame);
    self.playButton.center = CGPointMake(centerX,_playButton.center.y);
    [self updateCurrentView];
}

- (void)setVolumeValue:(float)value{
    self.value  =  value;
   // [self setupView];
}
@end
