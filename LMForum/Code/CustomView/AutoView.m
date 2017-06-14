//
//  AutoView.m
//  App
//
//  Created by Yu on 16/1/22.
//  Copyright © 2016年 HangZhou QiYi Technology Co.Ltd. All rights reserved.
//

#import "AutoView.h"

#define XIB_WIDTH 400

static const CGFloat AutoViewDefaultCornerRadius=0.0;

static const CGFloat AutoViewDefaultBorderWidth=0.0;

@implementation AutoView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (void)prepareForInterfaceBuilder {
    [self drawView];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawView];
}


/**
 以下项都是添加了一个比例系数，不需要可以直接注释掉代码
 */
-(void)drawView
{
    self.layer.masksToBounds=YES;
    
    CGFloat cornerRadius=self.cornerRadius?self.cornerRadius:AutoViewDefaultCornerRadius;
    
    CGFloat borderWidth=self.borderWidth?self.borderWidth:AutoViewDefaultBorderWidth;
    
    //圆角
    if (cornerRadius>0) {
#if TARGET_INTERFACE_BUILDER
        self.layer.cornerRadius=cornerRadius;
#else
        self.layer.cornerRadius=S_WIDTH*cornerRadius/XIB_WIDTH;
#endif
    }
    
    //边框
    if (borderWidth>0) {
        self.layer.borderWidth=S_WIDTH*borderWidth/XIB_WIDTH;
    }
    
    //边框颜色
    if (self.borderColor) {
        self.layer.borderColor=[self.borderColor CGColor];
    }
    

}


@end
