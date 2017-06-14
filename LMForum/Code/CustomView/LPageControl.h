//
//  LPageControl.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/2.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPageControlDelegate;

@interface LPageControl : UIPageControl

@property(nonatomic,weak) id<LPageControlDelegate> delegate;

@end

@protocol LPageControlDelegate<NSObject>
@optional
- (void)pageControl:(LPageControl *)pageControl didSelectPageIndex:(NSInteger)index;

@end
