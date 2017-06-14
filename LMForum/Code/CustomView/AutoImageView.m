//
//  AutoImageView.m
//  App
//
//  Created by Yu on 16/1/22.
//  Copyright © 2016年 HangZhou QiYi Technology Co.Ltd. All rights reserved.
//

#import "AutoImageView.h"


#define XIB_WIDTH 400

static const CGFloat AutoViewDefaultCornerRadius=0.0;


@implementation AutoImageView


- (void)prepareForInterfaceBuilder {
    [self drawView];
}


-(void)drawView
{
    
    self.layer.masksToBounds=YES;
    
    CGFloat cornerRadius=self.cornerRadius?self.cornerRadius:AutoViewDefaultCornerRadius;
    
    //圆角
    if (cornerRadius>0) {
#if TARGET_INTERFACE_BUILDER
        self.layer.cornerRadius=cornerRadius;
#else
        self.layer.cornerRadius=S_WIDTH*cornerRadius/XIB_WIDTH;
#endif
    }
    
    if (self.img) {
        [self setImage:self.img];
    }

}


@end
