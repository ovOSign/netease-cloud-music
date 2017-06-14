//
//  LProgressBar.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/9.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LProgressBar.h"
@interface LProgressBar(){
    BOOL loadFirst;
}

@property(nonatomic, strong)UIImageView *backgroundView;

@property(nonatomic, strong)UIButton *playButton;

@property(nonatomic, strong)UIImageView *currentView;

@property(nonatomic, strong)UIImageView *readyView;


@end

#define stretchImgFromMiddle(img)	[(img) stretchableImageWithLeftCapWidth:(img).size.width / 2 topCapHeight:(img).size.height / 2]

#define padding 10

@implementation LProgressBar

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:self.backgroundView];
        //readyView
        [self addSubview:self.readyView];
        //playButton不能加在imageview上，否则点击事件失效
        [self addSubview:self.playButton];
        
        [self addSubview:self.currentView];
        
       // [self setupView];
        
        self.dragFlag = false;
        
        loadFirst = true;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundView];
        //readyView
        [self addSubview:self.readyView];
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
    self.playButton.frame = CGRectMake(_backgroundView.frame.origin.x -_playButton.imageView.image.size.width*0.5, (self.frame.size.height-_playButton.imageView.image.size.height)*.5, _playButton.imageView.image.size.width, _playButton.imageView.image.size.height);

    //readyView
    self.readyView.frame = CGRectMake(_backgroundView.frame.origin.x, (self.frame.size.height-_readyView.image.size.height)*.5, _backgroundView.frame.size.width, _readyView.image.size.height);
    
    //currentView
    self.currentView.frame = CGRectMake(_backgroundView.frame.origin.x-padding, (self.frame.size.height-_currentView.image.size.height)*.5, 0, _currentView.image.size.height);
    
    [self bringSubviewToFront:self.playButton];
    
}

-(UIButton*)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"cm2_playbar_btn"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"cm2_playbar_btn_prs"] forState:UIControlStateHighlighted];
        UIImageView  *dot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cm2_playbar_btn_dot"]];
        dot.center = CGPointMake(_playButton.imageView.image.size.width*.5, _playButton.imageView.image.size.height*.5);
        [_playButton addSubview:dot];
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

-(UIImageView*)readyView{
    if (!_readyView) {
        UIImage *image = [UIImage imageNamed:@"cm2_playbar_ready"];
        _readyView = [[UIImageView alloc] initWithImage:stretchImgFromMiddle(image)];
    }
    return _readyView;
}

-(UIImageView*)currentView{
    if (!_currentView) {
        UIImage *image = [UIImage imageNamed:@"cm2_playbar_curr"];
        _currentView = [[UIImageView alloc] initWithImage:stretchImgFromMiddle(image)];
    }
    return _currentView;
}


- (IBAction)buttonDrag:(UIButton *)button withEvent:(UIEvent *)event {
    
    self.dragFlag = true;
    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    
    button.center = CGPointMake(MIN(CGRectGetWidth(self.bounds) - padding, MAX(padding, button.center.x + (point.x - lastPoint.x))),
                                button.center.y);
    if ([self.delegate respondsToSelector:@selector(progressBar:didSidler:)]) {
        CGFloat ratio =( button.center.x - padding)/ (CGRectGetWidth(self.bounds)- 2*padding);
       [self.delegate progressBar:self didSidler:ratio];
        
    }
    [self updateCurrentView];
}
- (IBAction)buttonAction:(UIButton *)button{
    self.dragFlag = false;
    if ([self.delegate respondsToSelector:@selector(progressBarEndDrag:didSidler:)]) {
        CGFloat ratio =( button.center.x - padding)/ (CGRectGetWidth(self.bounds)- 2*padding);
        [self.delegate progressBarEndDrag:self didSidler:ratio];
    }
    
}
-(void)updateCurrentView {
    CGRect currentViewFrame = CGRectMake(self.currentView.frame.origin.x,
                                         self.currentView.frame.origin.y,
                                         self.playButton.center.x ,
                                         self.currentView.bounds.size.height);
    self.currentView.frame = currentViewFrame;
}
#pragma mark - public
- (void)setRatio:(float)ratio animated:(BOOL)animated{
        CGFloat centerX = (CGRectGetWidth(self.bounds)- 2*padding)*ratio+CGRectGetMinX(self.backgroundView.frame);
        self.playButton.center = CGPointMake(centerX,_playButton.center.y);
        [self updateCurrentView];
}

@end
