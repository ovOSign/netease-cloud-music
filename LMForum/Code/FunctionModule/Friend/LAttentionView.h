//
//  LAttentionView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/28.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LStatusLayout.h"
@protocol LAttentionViewDelegate;

@interface LAttentionView : UIView

@property(nonatomic, strong)NSMutableArray *layouts;

@property(nonatomic,weak) id<LAttentionViewDelegate> delegate;

@property(nonatomic, strong)UITableView *tableView;

@end

@protocol LAttentionViewDelegate<NSObject>

- (void)attentionView:(LAttentionView *)attentionView
       didSelectDetailModel:(LStatusLayout *)layout;

- (void)attentionView:(LAttentionView *)attentionView didShareAction:(UIButton*)button;

@end

