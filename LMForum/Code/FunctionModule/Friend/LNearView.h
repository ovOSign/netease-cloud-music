//
//  LNearView.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LNearViewDelegate;

@interface LNearView : UIView

@property(nonatomic, strong)NSMutableArray *layouts;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic,weak) id<LNearViewDelegate> delegate;

@end


@protocol LNearViewDelegate<NSObject>


@end
