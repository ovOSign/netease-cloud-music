//
//  LLrcMainView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVolumeView.h"
#import "LLrcScrollView.h"
@protocol LLrcMainViewDelegate;
@interface LLrcMainView : UIView

@property (weak, nonatomic) id<LLrcMainViewDelegate> delegate;

@property(nonatomic, strong)LLrcScrollView *lrcScrollView;

@property(nonatomic, strong)LVolumeView *volumeView;

- (void)setVolumeValueByRatio:(float)ratio animated:(BOOL)animated;

- (void)setVolumeValue:(float)value;

-(void)reloadLrcArray:(NSMutableArray*)array;

@end

@protocol LLrcMainViewDelegate <NSObject>

@end
