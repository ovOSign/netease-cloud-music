//
//  LPlayMusicView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/6.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPlayMusicViewDelegate;

@interface LPlayMusicView : UIView

@property(nonatomic,weak) id<LPlayMusicViewDelegate> delegate;

-(void)startScrollLabel;

-(void)resetScroll;

@end

@protocol LPlayMusicViewDelegate <NSObject>

- (void)playMusicView:(LPlayMusicView *)playMusicView returnToPrevious:(BOOL)back;

- (void)playMusicView:(LPlayMusicView *)playMusicView translateX:(CGFloat)translateX;

- (void)playMusicView:(LPlayMusicView *)playMusicView translateEnd:(BOOL)end;

@end
