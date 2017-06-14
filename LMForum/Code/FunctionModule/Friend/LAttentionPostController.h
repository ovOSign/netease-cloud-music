//
//  LAttentionPostController.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBackViewController.h"
#import "LStatusLayout.h"
@interface LAttentionPostController : LBackViewController
- (void)setLayout:(LStatusLayout *)layout;
@property (nonatomic, copy) void (^dismiss)(void);
@end
