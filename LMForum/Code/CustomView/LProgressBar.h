//
//  LProgressBar.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/9.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LProgressBarDelegate;

@interface LProgressBar : UIView

@property (nonatomic) BOOL dragFlag;

@property(nonatomic,weak) id<LProgressBarDelegate> delegate;

- (void)setRatio:(float)ratio animated:(BOOL)animated;

@end

@protocol LProgressBarDelegate <NSObject>

- (void)progressBar:(LProgressBar *)progressBar didSidler:(CGFloat)ratio;

- (void)progressBarEndDrag:(LProgressBar *)progressBar didSidler:(CGFloat)ratio;

@end
