//
//  RecommendView.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/12.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTableView.h"

@protocol RecommendViewDelegate;

@interface RecommendView : UIView

@property (strong, nonatomic) NSMutableArray *dataArray;

@property(nonatomic,weak) id<RecommendViewDelegate> delegate;

@property(nonatomic, strong)LTableView *tableView;

-(void)loadColumSetList;

-(void)startLoadingColumSetData;

-(void)stopLoadingColumSetData;

@end

@protocol RecommendViewDelegate <NSObject>

- (void)recommendView:(RecommendView *)view didSelectSetColumButton:(BOOL)select;

@end
