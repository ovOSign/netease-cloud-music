//
//  LConstant.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//
///常量类
#import <Foundation/Foundation.h>

@interface LConstant : NSObject
///屏幕宽度
#define S_WIDTH ([[UIScreen mainScreen] bounds].size.width)

///屏幕高度
#define S_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

///屏幕高度(除去状态栏和导航栏)
#define WORK_S_HEIGHT (S_HEIGHT-64)

///设置字体大小
#define Font(f) [UIFont systemFontOfSize:f]

///设置颜色
#define RGB(r, g, b, f) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:f/1.0f]


#define MAINIMAGECOLOR [UIImage imageNamed:@"cm2_topbar_bg"]

#define MAINIBACKGROUNDCOLOR RGB(250, 251, 252, 1)


#define colorGray RGB(82, 82, 82, 1)

#define colorGray1 [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1]

#define colorGray2 RGB(191, 191, 191, 1)

#define colorBlack RGB(38, 38, 38, 1)
///字体自适应
#define H1 ceilf(S_WIDTH*0.05)

#define H2 ceilf(S_WIDTH*0.045)

#define H3 ceilf(S_WIDTH*0.04)

#define H4 ceilf(S_WIDTH*0.035)

#define H5 ceilf(S_WIDTH*0.03)

#define H6 ceilf(S_WIDTH*0.025)

#define H7 ceilf(S_WIDTH*0.02)

#define H8 ceilf(S_WIDTH*0.015)

#define H9 ceilf(S_WIDTH*0.01)

#define H10 ceilf(S_WIDTH*0.005)

///比例 6splus
#define H_SCALE (S_HEIGHT/736)

#define W_SCALE (S_WIDTH/414)



//cell左右边距
#define cellMargin  10*W_SCALE
//cell上下内边距
#define cellIndicatorTopMargin 15*H_SCALE
//cell内部上下内边距
#define cellIndicatorTopPadding 10*H_SCALE


#define drogblank 44



#define SHOWPLAYMUSICVIEW @"showplaymusicview"

@end
