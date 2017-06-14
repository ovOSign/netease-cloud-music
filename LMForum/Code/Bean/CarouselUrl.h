//
//  CarouselUrl.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/14.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, LTagViewModel) {
    LTagViewModelNormal = 0,
    LTagViewModelHot = 1
};

@interface CarouselUrl : NSObject

@property(nonatomic, strong)NSString *url;

@property(nonatomic,strong)NSString *tagName;

@property(nonatomic)NSInteger index;

@property(nonatomic)LTagViewModel model;

@end
