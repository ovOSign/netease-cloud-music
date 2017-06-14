//
//  LVolumeBar.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LVolumeBarDelegate;

@interface LVolumeBar : UIView

@property(nonatomic, strong)UIImageView *volImagew;

@property(nonatomic,weak) id<LVolumeBarDelegate> delegate;

- (void)setRatio:(float)ratio animated:(BOOL)animated;

- (void)setVolumeValue:(float)value;

@end
@protocol LVolumeBarDelegate <NSObject>

- (void)volumeBar:(LVolumeBar *)volumeBar didSidler:(CGFloat)ratio;


@end
