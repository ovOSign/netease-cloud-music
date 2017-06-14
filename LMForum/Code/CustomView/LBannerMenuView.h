//
//  LBannerMenuView.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/26.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewBean.h"
@protocol LBannerMenuDataSource;

@protocol LBannerMenuDataDelegate;

@interface LBannerMenuView : UIView

@property(nonatomic,weak) id<LBannerMenuDataSource> dataSource;

@property(nonatomic,weak) id<LBannerMenuDataDelegate> delegate;

@property(nonatomic)BOOL showPageControl;
@property(nonatomic,strong)UIColor *pageIndicatorTintColor;
@property(nonatomic,strong)UIColor *currentPageIndicatorTintColor;
@end



@protocol LBannerMenuDataSource<NSObject>


- (NSInteger)numberOfItemsInBannerMenuView:(LBannerMenuView *)bannerMenuView;

- (GridViewBean *)gridViewBean:(LBannerMenuView *)bannerMenuView gridViewBeanForItemWithIndex:(NSInteger)index;


@end

@protocol LBannerMenuDataDelegate <NSObject>
@optional
- (void)gridViewBean:(GridViewBean *)gridViewBean didSelectGridViewWithIndex:(NSInteger)index;

@end
