//
//  LDiscMainView.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/10.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LDiscMainView.h"
#import "LDiscOperBar.h"
@interface LDiscMainView()

@property(nonatomic, strong)UIImageView *needleImageView;


@property(nonatomic, strong)LDiscOperBar *discOperBar;

@end

#define AnimationDuration 0.5

#define padding 20

#define rotation M_PI /6

@implementation LDiscMainView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        UIImage *needleImage = [self _needleImage];
        CGPoint point = [self needleImagePoint:needleImage];
        //_needleImageView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointMake((frame.size.width*.5), 0),needleImage.size}];
        _needleImageView = [[UIImageView alloc] init];
        [_needleImageView setImage:needleImage];
        _needleImageView.layer.anchorPoint = CGPointMake(point.x/needleImage.size.width, point.y/needleImage.size.height);
        _needleImageView.bounds = (CGRect){CGPointMake(0, 0),needleImage.size};
        _needleImageView.layer.position = CGPointMake((frame.size.width*.5), 0);
        
        
        UIImage *discImage = [self _discImage];
        CGRect discFrame = (CGRect){CGPointMake(0, [self discViewWidth]-padding),frame.size.width,discImage.size.height+padding*2};
        _scrollDiscView = [[LScrollDiscView alloc] initWithFrame:discFrame disImage:discImage];
        [self addSubview:_scrollDiscView];
        [self addSubview:_needleImageView];
        [self addSubview:self.discOperBar];
        
        [self releaseNeedleAnimation:false];
        
    }
    return self;
}
#pragma mark - getter
-(LScrollDiscView*)scrollDiscView{
    if (!_scrollDiscView) {
        _scrollDiscView = [[LScrollDiscView alloc] init];
    }
    
    return _scrollDiscView;
}

-(LDiscOperBar*)discOperBar{
    if (!_discOperBar) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LDiscOperBar" owner:nil options:nil];
        _discOperBar = [array objectAtIndex:0];
        CGFloat height = self.frame.size.width*50/400;
        _discOperBar.frame = CGRectMake(0, self.frame.size.height-height, self.frame.size.width,height);
    }
    
    return _discOperBar;
}
#pragma mark - setter
-(void)setDelegate:(id<LDiscMainViewDelegate>)delegate{
    _delegate = delegate;
    if ([_scrollDiscView isKindOfClass:[LScrollDiscView class]]) {
        [(LScrollDiscView *)_scrollDiscView setDelegate:(id<LScrollDiscViewDelegate>)delegate];
    }
}

-(void)setSongImage:(id) obj completed:(void(^)(UIImage* image))completion{
    [_scrollDiscView setSongImage:obj completed:^(UIImage *image) {
        completion(image);
    }];
}

#pragma mark - private
-(CGPoint)needleImagePoint:(UIImage*)image{

    NSInteger deivce  = [CommonUtils deivceType];
    if (deivce == 0) {
        return CGPointMake(27, 26);
    }else if(deivce ==1 || deivce ==2 ){
        return CGPointMake(31, 30);
    }else {
       return CGPointMake(96, 56);
    }
}

-(UIImage*)_discImage{
    NSInteger deivce  = [CommonUtils deivceType];
    UIImage *discImage;
    if (deivce == 0) {
        discImage = [UIImage imageNamed:@"cm2_play_disc"];
    }else if(deivce ==1 ){
        discImage = [UIImage imageNamed:@"cm2_play_disc-ip6"];
    }else if(deivce ==2 ){
        discImage = [UIImage imageNamed:@"cm2_play_disc"];
    }
    return discImage;
}

-(CGSize)scrollDiscSize{
    UIImage *img =  [self _discImage];
    
    return img.size;
}

-(UIImage*)_needleImage{
    NSInteger deivce  = [CommonUtils deivceType];
    UIImage *needleImage;
    if (deivce == 0) {
        needleImage = [UIImage imageNamed:@"cm2_play_needle_play-568h@2x"];
    }else if(deivce ==1 ){
        needleImage = [UIImage imageNamed:@"cm2_play_needle_play-ip6"];
    }else if(deivce ==2 ){
        needleImage = [UIImage imageNamed:@"cm2_play_needle_play"];
    }
    return needleImage;
}


-(CGFloat)discViewWidth{
    NSInteger deivce  = [CommonUtils deivceType];
    if (deivce == 0) {
        return 64;
    }else if(deivce ==1 ){
        return 82;
    }else if(deivce ==2 ){
        return 86;
    }
    return 86;
}

#pragma mark - Animation

-(void)releaseNeedleAnimation:(BOOL)animation{
    CGAffineTransform angle = CGAffineTransformMakeRotation(-rotation);
    if (animation == true) {
        [UIView animateWithDuration:AnimationDuration animations:^{
            _needleImageView.transform = angle;
        } completion:nil];
    }else{
         _needleImageView.transform = angle;
    }
    _puted = false;
}
-(void)putNeedleAnimation:(BOOL)animation{
    if (animation == true) {
        [UIView animateWithDuration:AnimationDuration animations:^{
           _needleImageView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    else{
       _needleImageView.transform = CGAffineTransformIdentity;
    }
    _puted = true;
}
@end
