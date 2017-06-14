//
//  LScrolLabel.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LScrolLabel.h"
@interface LScrolLabel()<UIScrollViewDelegate>{
    NSTimer *timer;
}

@property(nonatomic, strong)NSMutableArray *views;

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UILabel *singerLabel;

@property(nonatomic)CGFloat songFontSize ;

@property(nonatomic)CGFloat singerFontSize;
@end

#define blank 20
#define AnimationDuration 4////动画持续时间

@implementation LScrolLabel



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height*2/3)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.delegate = self;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_scrollView];
        
       _singerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame)+2, frame.size.width, frame.size.height*1/3)];
       [self addSubview:_singerLabel];
       
        
        
        
        _views = [NSMutableArray array];
        _songFontSize = _scrollView.frame.size.height-2;
        _songColor = [UIColor whiteColor];
        
        _singerFontSize = _singerLabel.frame.size.height+2;
        _singerColor = [UIColor whiteColor];
    }
    return self;
}


-(void)reloadData{
    for (UILabel *view in self.views) {
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    CGSize size = [CommonUtils sizeForString:_songName Font:Font(_songFontSize) ConstrainedToSize:CGSizeMake(1000, 1000) LineBreakMode:NSLineBreakByWordWrapping];
    if (size.width < self.frame.size.width) {
        UILabel *songLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _songFontSize)];
        songLabel.text = _songName;
        songLabel.font = Font(_songFontSize);
        songLabel.textAlignment = NSTextAlignmentCenter;
        songLabel.textColor = _songColor;
        [_scrollView addSubview:songLabel];
        [self.views addObject:songLabel];
    }else{
       for (NSInteger index = 0; index < 2; index++){
           UILabel *songLabel = [[UILabel alloc] initWithFrame:CGRectMake((size.width+blank)*index,0, size.width+blank, _songFontSize)];
           songLabel.text = _songName;
           songLabel.font = Font(_songFontSize);
           songLabel.textAlignment = NSTextAlignmentLeft;
           songLabel.textColor = _songColor;
           songLabel.tag = index;
           [_scrollView addSubview:songLabel];
           [self.views addObject:songLabel];
       }
    }
    _singerLabel.text = _singerName;
    _singerLabel.font = Font(_singerFontSize);
    _singerLabel.textAlignment = NSTextAlignmentCenter;
    _singerLabel.textColor = _singerColor;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (!self.views.count) {
        [self reloadData];
    }
    
}

-(void)startScroll{
    [self resetScroll];
    if (self.views.count == 2) {
        NSTimeInterval  timerInterval = _songName.length*.2;
        timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval+4 target:self selector:@selector(animationScroll) userInfo:nil repeats:YES];
    }
}

-(void)setSongName:(NSString *)songName singer:(NSString *)singerName{
    _songName = songName;
    _singerName = singerName;
    [self reloadData];
    [self startScroll];
}

-(void)animationScroll{
    NSTimeInterval  timerInterval = _songName.length*.2;
    [UIScrollView animateWithDuration:timerInterval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        UILabel *label = [self.views firstObject];
        _scrollView.contentOffset = CGPointMake(label.frame.size.width, 0);
    } completion:^(BOOL finished) {
        _scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

-(void)resetScroll{
     _scrollView.contentOffset = CGPointMake(0, 0);
    if (self.views.count  == 2) {
        [timer invalidate];
        timer = nil;
        _scrollView.contentOffset = CGPointMake(0, 0);
    }
}
@end
