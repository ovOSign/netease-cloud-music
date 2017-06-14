//
//  UserCenterController.h
//  LMForum
//
//  Created by 梁海军 on 2017/5/15.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBackViewController.h"
@interface UserCenterController : LBackViewController<UITabBarControllerDelegate>

@property (nonatomic, copy) void (^dismiss)(void);

@property (nonatomic, strong) User *user;

- (instancetype)initWithUserCenterController:(id)user;

@end
