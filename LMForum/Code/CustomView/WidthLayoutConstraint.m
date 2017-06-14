//
//  WidthLayoutConstraint.m
//  App
//
//  Created by Yu on 16/3/19.
//  Copyright © 2016年 HangZhou QiYi Technology Co.,Ltd. All rights reserved.
//

#import "WidthLayoutConstraint.h"

@implementation WidthLayoutConstraint

-(CGFloat)constant
{
    return ([super constant]*S_WIDTH/400);
}


@end
