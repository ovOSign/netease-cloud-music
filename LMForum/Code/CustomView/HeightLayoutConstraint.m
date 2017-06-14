//
//  HeightLayoutConstraint.m
//  App
//
//  Created by Yu on 16/3/19.
//  Copyright © 2016年 HangZhou QiYi Technology Co.,Ltd. All rights reserved.
//

#import "HeightLayoutConstraint.h"

@implementation HeightLayoutConstraint

-(CGFloat)constant
{
    return ([super constant]*S_HEIGHT/800);
}

@end
