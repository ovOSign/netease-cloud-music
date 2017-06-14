//
//  FriendController.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LViewController.h"
#import "LAttentionView.h"
#import "LNearView.h"
@interface FriendController : LViewController

@property(nonatomic , strong)UIButton *playingButton;

@property(nonatomic, strong)LAttentionView *attentionView;

@property(nonatomic, strong)LNearView *nearView;

-(void)showAttentionView;

-(void)showNearView;

@end
