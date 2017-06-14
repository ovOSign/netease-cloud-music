//
//  LAttentionDetailController.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LStatusLayout.h"
#import "LBackViewController.h"
@interface LAttentionDetailController : LBackViewController

@property(nonatomic) bool upToBottom;

@property(nonatomic , strong)UIButton *playingButton;

@property (nonatomic, copy) void (^dismiss)(void);

- (void)setLayout:(LStatusLayout *)layout;

@end
