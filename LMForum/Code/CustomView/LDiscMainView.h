//
//  LDiscMainView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/10.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LScrollDiscView.h"
@protocol LDiscMainViewDelegate;

@interface LDiscMainView : UIView

@property (weak, nonatomic) id<LDiscMainViewDelegate> delegate;

@property(nonatomic, strong)LScrollDiscView *scrollDiscView;

@property(nonatomic) bool puted;

-(void)putNeedleAnimation:(BOOL)animation;

-(void)releaseNeedleAnimation:(BOOL)animation;

-(void)setSongImage:(id) obj completed:(void(^)(UIImage* image))completion;

@end

@protocol LDiscMainViewDelegate <NSObject>

@end
