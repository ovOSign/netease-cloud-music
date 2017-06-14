//
//  RankBean.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/4.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, LRankType) {
    LRankTypeUp = 0,
    LRankTypeHot = 1,
    LRankTypeOriginal = 2,
    LRankTypeNew = 3,
};

@interface RankBean : NSObject
@property(nonatomic) LRankType model;
@property(nonatomic, strong) NSString *firstItem;
@property(nonatomic, strong) NSString *secondItem;
@property(nonatomic, strong) NSString *thirdItem;
@end
