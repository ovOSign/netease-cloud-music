//
//  LNearModel.h
//  LMForum
//
//  Created by 梁海军 on 2017/5/15.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface LNearModel : NSObject

@property(nonatomic, strong)User *user;

@property(nonatomic, strong)NSString *distance;

@property(nonatomic, strong)NSString *time;

@property(nonatomic, strong)NSString *song;

@property(nonatomic, strong)NSString *singer;

@end
