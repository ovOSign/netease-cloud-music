//
//  LScrollDiscView.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/10.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LScrollDiscView.h"

@interface LDiscImageView : UIView{
    UIView *contentView;
    
}


@property(nonatomic, strong)UIImageView *disImageView;


@property(nonatomic, strong)UIImageView *songImageView;


-(void)startRotationAnimation;

-(void)stopRotationAnimation;

@end

#define padding 20

@implementation LDiscImageView

-(instancetype)initWithDisImage:(UIImage*)image{
    self = [super initWithFrame:(CGRect){CGPointZero,image.size}];
    if (self) {
        CGFloat originX= (S_WIDTH -image.size.width)*.5;
        
        contentView = [[UIView alloc] initWithFrame:(CGRect){CGPointMake(originX, padding), image.size}];
        [self addSubview:contentView];
        
        _disImageView = [[UIImageView alloc] initWithImage:image];
        _disImageView.frame = (CGRect){CGPointMake(0, 0), image.size};
        
        UIImage *songImage = [self _songImage];
        _songImageView = [[UIImageView alloc] initWithImage:songImage];
        _songImageView.frame = (CGRect){CGPointMake((image.size.width-songImage.size.width)*.5, (image.size.height-songImage.size.height)*.5), songImage.size};
        
        [contentView addSubview:_songImageView];
        
        [contentView addSubview:_disImageView];

    }
    return self;
}

-(UIImage*)_songImage{
    UIImage *songImage = [UIImage imageNamed:@"cm2_default_cover_play"];
    return songImage;
}


//- (void)rotationAnimation{
//    angle+=0.02;
//    if (angle==360.0) angle=0;
//    [UIView beginAnimations:nil context:nil];
//    contentView.transform=CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
//    [UIView commitAnimations];
//}

-(void)startRotationAnimation{
    [self resumeRotationAnimation];
    //1.创建基本动画
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //2.设置属性
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI * 2);
    rotateAnim.repeatCount = NSIntegerMax;
    rotateAnim.duration = 40;
    //3.添加动画到图上
    [contentView.layer addAnimation:rotateAnim forKey:nil];
}

-(void)stopRotationAnimation{
    CFTimeInterval pausedTime = [contentView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    contentView.layer.speed = 0.0;
    contentView.layer.timeOffset = pausedTime;
}
-(void)resumeRotationAnimation{
    CFTimeInterval pausedTime = [contentView.layer timeOffset];
    contentView.layer.speed = 1.0;
    contentView.layer.timeOffset = 0.0;
    contentView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [contentView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    contentView.layer.beginTime = timeSincePause;
}


@end


@interface LScrollView : UIScrollView


@end

@implementation LScrollView
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint loc=[touch locationInView:self.superview];
    if (loc.x > drogblank) {
        self.scrollEnabled = YES;
    }else{
        self.scrollEnabled = false;
    }
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    self.scrollEnabled = YES;
}

@end


@interface LScrollDiscView()<UIScrollViewDelegate>

@property(nonatomic, strong)LScrollView *scrollView;

@property(nonatomic, strong)UIView *contentView;

@property(nonatomic, strong)NSMutableArray *views;

@property(nonatomic, strong)UIImage *disImage;

@property(nonatomic, strong)UIImage *currentDiscImage;

@property(nonatomic, strong)LDiscImageView *currentDiscV;

@property(nonatomic) LDiscState  discState;

@end

@implementation LScrollDiscView

-(instancetype)initWithFrame:(CGRect)frame disImage:(UIImage*)image{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[LScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];
        
        
        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:_contentView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];
        
        _views = [NSMutableArray array];
        _disImage = image;
    }
    return self;
}

-(void)reloadData{
    for (UIImageView *view in self.views) {
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    
    LDiscImageView *previousView;
    for (NSInteger index = 0; index < 3; index++){
        LDiscImageView *imageView= [[ LDiscImageView  alloc] initWithDisImage:_disImage];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:imageView];
        if (previousView) {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView]-0-[imageView]"
                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                     metrics:nil
                                                                                       views:NSDictionaryOfVariableBindings(previousView, imageView)]];
        }else {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]"
                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                     metrics:nil
                                                                                       views:NSDictionaryOfVariableBindings(imageView)]];
        }
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:self.frame.size.height]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:self.frame.size.width]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0.0]];
        
        previousView = imageView;
        
        [self.views addObject:imageView];
        
        if (index == 1) {
            _currentDiscV = imageView;
            if (_currentDiscImage) {
                [_currentDiscV.songImageView setImage: _currentDiscImage];
            }
            if(self.animationBool){
               [self startRotationAnimation];
                self.animationBool = false;
            }
        }
    }
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView]|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(previousView)]];
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    
    
    [self updateConstraintsIfNeeded];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (!self.views.count) {
        [self reloadData];
    }
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

  
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(scrollDiscViewDidScroll:)]) {
        [self.delegate scrollDiscViewDidScroll:self];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x > scrollView.frame.size.width) {
        self.discState = LDiscStateRight;
    }else if (scrollView.contentOffset.x <= 0) {
        self.discState = LDiscStateLeft;
    }else{
        self.discState = LDiscStateDefault;
    }
    
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    switch (self.discState) {
        case LDiscStateDefault:
            
            if ([self.delegate respondsToSelector:@selector(scrollDiscViewDidEndDecelerating:state:)]) {
                [self.delegate scrollDiscViewDidEndDecelerating:self state:LDiscStateDefault];
            }
            break;
        case LDiscStateLeft:
     
            if ([self.delegate respondsToSelector:@selector(scrollDiscViewDidEndDecelerating:state:)]) {
                [self.delegate scrollDiscViewDidEndDecelerating:self state:LDiscStateLeft];
            }
            break;
        case LDiscStateRight:
           
            if ([self.delegate respondsToSelector:@selector(scrollDiscViewDidEndDecelerating:state:)]) {
                [self.delegate scrollDiscViewDidEndDecelerating:self state:LDiscStateRight];
            }
            break;
            
        default:
            break;
    }
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > scrollView.frame.size.width) {
        self.discState = LDiscStateRight;
    }else if (scrollView.contentOffset.x <= 0) {
        self.discState = LDiscStateLeft;
    }else{
        self.discState = LDiscStateDefault;
    }
    
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    switch (self.discState) {
        case LDiscStateDefault:
            
            if ([self.delegate respondsToSelector:@selector(scrollDiscViewDidEndDecelerating:state:)]) {
                [self.delegate scrollDiscViewDidEndDecelerating:self state:LDiscStateDefault];
            }
            break;
        case LDiscStateLeft:
            
            if ([self.delegate respondsToSelector:@selector(scrollDiscViewDidEndDecelerating:state:)]) {
                [self.delegate scrollDiscViewDidEndDecelerating:self state:LDiscStateLeft];
            }
            break;
        case LDiscStateRight:
            
            if ([self.delegate respondsToSelector:@selector(scrollDiscViewDidEndDecelerating:state:)]) {
                [self.delegate scrollDiscViewDidEndDecelerating:self state:LDiscStateRight];
            }
            break;
            
        default:
            break;
    }
    
}

-(void)setSongImage:(id)obj completed:(void(^)(UIImage* image))completion{
    if ([obj isKindOfClass:[NSURL class]]) {
        [_currentDiscV.songImageView sd_setImageWithURL:obj
                                       placeholderImage: [UIImage imageNamed:@"cm2_default_cover_play"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           completion(image);
                                       }];
    }else if([obj isKindOfClass:[NSString class]]){
        UIImage *image = [UIImage imageNamed:obj];
        [_currentDiscV.songImageView  setImage:image];
        completion(image);
        if (!_currentDiscV) {
            _currentDiscImage = image;
        }
    }

}


-(void)next{
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
}

-(void)previous{
   [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


-(void)startRotationAnimation{
     [_currentDiscV startRotationAnimation];
    self.animationing = true;
}

-(void)stopRotationAnimation{
     [_currentDiscV stopRotationAnimation];
    self.animationing = false;
}

-(void)resumeRotationAnimation{
    [_currentDiscV resumeRotationAnimation];
    self.animationing = true;
}

@end
