//
//  UserDefaults.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/22.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+(void)setToUserDefaults:(NSString*)key Value:(id)value
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value forKey:key];
    
    [userDefaults synchronize];
}




+(id)getFromUserDefaults:(NSString*)key
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSString *value=[userDefaults objectForKey:key];
    
    if([UserDefaults isNull:value]){
        return nil;
    }else{
        return value;
    }
}

+(BOOL)isNull:(NSString*) str
{
    if([str isKindOfClass:[NSNull class]]||str==nil||str==NULL){
        return YES;
    }else{
        NSString *str1=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([str1 isEqualToString:@""]||str1.length<1) {
            return YES;
        }
        return NO;
    }
}
//获取栏目调整顺序
//1.推荐歌单
//2.独家放送
//3.最新音乐
//4.推荐MV
//5.主播电台
+(void)setColumSetListArray:(NSArray *)array{

    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:array forKey:columListKey];
    
    [userDefaults synchronize];
}
+(NSArray *)getColumSetList{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSArray *array=[userDefaults objectForKey:columListKey];
    
    if (array == nil) {
     array  =  [NSArray arrayWithObjects:@(0),@(1),@(2),@(3),@(4), nil];
    }
    return array;
}
  
@end
