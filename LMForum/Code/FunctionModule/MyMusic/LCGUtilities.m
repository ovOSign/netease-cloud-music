//
//  LCGUtilities.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/29.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LCGUtilities.h"

CGFloat LScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}
