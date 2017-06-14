//
//  LLrcScrollView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMusicLrcModel.h"

@protocol LLrcScrollViewDelegate;

@interface LLrcScrollView : UIView

@property(nonatomic,weak) id<LLrcScrollViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic,copy) NSString *lrcName;

/** 当前播放的时间 */
@property (nonatomic,assign) NSTimeInterval currentTime;

/** 当前歌曲的总时长 */
@property (nonatomic, assign) NSTimeInterval duration;


-(void)reloadData;

@end


@protocol LLrcScrollViewDelegate <NSObject>

- (void)lrcScrollView:(LLrcScrollView *)lrcScroll currentIndicateTime:(NSTimeInterval)time;

@end
