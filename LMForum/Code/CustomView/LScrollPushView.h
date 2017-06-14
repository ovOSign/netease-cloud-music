//
//  LScrollView.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LScrollViewDelegate;

@interface LScrollPushView : UIView

@property(nonatomic, strong)UINavigationBar *navigationBar;

@property(nonatomic, strong)UINavigationItem *navigationItem;

@property(nonatomic,weak) id<LScrollViewDelegate> delegate;

-(void)backAction:(UIButton *)button;

@end

@protocol LScrollViewDelegate <NSObject>

- (void)scrollView:(UIView *)view returnToPrevious:(BOOL)back;

- (void)scrollView:(UIView *)view translateX:(CGFloat)translateX;

- (void)scrollView:(UIView *)view translateEnd:(BOOL)end;

@end
