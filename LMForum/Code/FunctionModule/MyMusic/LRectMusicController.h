//
//  LRectMusicController.h
//  LMForum
//
//  Created by 梁海军 on 2017/5/16.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LBackViewController.h"

@interface LRectMusicController : LBackViewController<UITabBarControllerDelegate>
@property (nonatomic, copy) void (^dismiss)(void);
@end
