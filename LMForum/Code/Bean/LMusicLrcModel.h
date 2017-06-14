//
//  LMusicLrcModel.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMusicLrcModel : NSObject

@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) NSTimeInterval time;

- (instancetype) initWithLrcString:(NSString *)lrcString;
+ (instancetype) lrcLineString:(NSString *)lrcLineString;

@end
