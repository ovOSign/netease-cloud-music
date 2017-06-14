//
//  UserManager.m
//  LMForum
//
//  Created by 梁海军 on 2017/5/12.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "UserManager.h"

@interface UserManager()

@end

@implementation UserManager
+ (instancetype)sharedInstance{
    static UserManager *sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(User*)user{
    if (!_user) {
        _user = [[User alloc]init];
        _user.name = @"grifftth";
        _user.avatar = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494654210616&di=928eec9123b972ae0894ca704cc682d4&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201512%2F19%2F20151219190901_yPaVf.thumb.224_0.jpeg"];
    }
    return _user;
}

@end
