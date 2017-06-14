//
//  UserDefaults.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/22.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+(void)setToUserDefaults:(NSString*)key Value:(id)value;

+(id)getFromUserDefaults:(NSString*)key;




//获取栏目调整顺序
//1.推荐歌单
//2.独家放送
//3.最新音乐
//4.推荐MV
//5.主播电台
+(NSArray *)getColumSetList;
+(void)setColumSetListArray:(NSArray *)array;
@end
