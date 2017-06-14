//
//  RankingView.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/12.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTableView.h"

@interface RankingView : UIView

@property (strong, nonatomic) NSMutableArray *dataArray;

@property(nonatomic, strong)LTableView *tableView;

@end
