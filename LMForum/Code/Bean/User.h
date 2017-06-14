//
//  User.h
//  LMForum
//
//  Created by 梁海军 on 2017/5/12.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, strong) NSString *ID;

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) id avatar;

@property(nonatomic, strong) id headImage;

@property(nonatomic, assign) int32_t sex;

@property(nonatomic, assign) int32_t lv;

@property(nonatomic, strong) NSString *jieshao;

@property(nonatomic, strong) NSString *dizhi;

@property(nonatomic, strong) NSString *niandai;

@property(nonatomic, strong) NSString *xingzuo;

@property(nonatomic, assign) int32_t dongtaiCount;
@property(nonatomic, assign) int32_t guanzhuCount;
@property(nonatomic, assign) int32_t fansCount;

@end
