//
//  LScrollView.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LScrollPushView.h"

@interface LScrollPushView()<UIGestureRecognizerDelegate>

@end
@implementation LScrollPushView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.navigationBar];
        
        self.backgroundColor = MAINIBACKGROUNDCOLOR;
        //左滑
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePan:)];
        panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:panGestureRecognizer];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self bringSubviewToFront:self.navigationBar];
}

-(UINavigationBar*)navigationBar{
    if (!_navigationBar) {
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        [_navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [_navigationBar setBackgroundImage:MAINIMAGECOLOR forBarMetrics:UIBarMetricsDefault];
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
        _navigationItem.titleView.tintColor = [UIColor whiteColor];
        
        
    }
    return _navigationItem;
}


-(void) handlePan:(UIPanGestureRecognizer*) recognizer{
    CGPoint translatedPoint = [recognizer translationInView:self.superview];
    
    if ([self.delegate respondsToSelector:@selector(scrollView:translateX:)]) {
        [self.delegate scrollView:self translateX:translatedPoint.x];
    }
    
    if(recognizer.state == UIGestureRecognizerStateEnded){
        if ([self.delegate respondsToSelector:@selector(scrollView:translateEnd:)]) {
            [self.delegate scrollView:self translateEnd:true];
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

#pragma mark - Action
-(void)backAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(scrollView:returnToPrevious:)]) {
        [self.delegate scrollView:self returnToPrevious:YES];
        //重置
        // [self resetScroll];
    }
}

@end
