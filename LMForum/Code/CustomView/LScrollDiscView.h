//
//  LScrollDiscView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/10.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LDiscStateDefault,
    LDiscStateLeft,
    LDiscStateRight
} LDiscState;


@protocol LScrollDiscViewDataSource;

@protocol LScrollDiscViewDelegate;

@interface LScrollDiscView : UIView

@property(nonatomic,weak) id<LScrollDiscViewDelegate> delegate;

@property(nonatomic) BOOL  animationing;


//初始化就开启动画
@property(nonatomic) BOOL  animationBool;

-(instancetype)initWithFrame:(CGRect)frame disImage:(UIImage*)image;

-(void)setSongImage:(id)obj completed:(void(^)(UIImage* image))completion;

-(void)next;

-(void)previous;

-(void)startRotationAnimation;

-(void)stopRotationAnimation;

-(void)resumeRotationAnimation;

@end

@protocol LScrollDiscViewDelegate<NSObject>

- (void)scrollDiscViewDidEndDecelerating:(LScrollDiscView *)scrollDiscView state:(LDiscState)state ;

- (void)scrollDiscViewDidScroll:(LScrollDiscView *)scrollDiscView ;

@end
