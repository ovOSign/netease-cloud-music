//
//  UserManager.h
//  LMForum
//
//  Created by 梁海军 on 2017/5/12.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserManager : NSObject
+ (instancetype)sharedInstance;

@property(nonatomic, strong)User *user;

@end
