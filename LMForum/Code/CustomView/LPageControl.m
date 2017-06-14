//
//  LPageControl.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/2.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LPageControl.h"



@implementation LPageControl

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    
    CGPoint loc=[touch locationInView:self];
    UIView *itemView = nil;
    
    for (int i = 0; i < [self.subviews count] ;i++) {
        UIView *view = [self.subviews objectAtIndex:i];
        view.tag = i+100;
        if(!CGRectContainsPoint(view.frame, loc)) continue;
        itemView = view;
        break;
    }
    if (itemView.tag >= 100) {
        if ([self.delegate respondsToSelector:@selector(pageControl:didSelectPageIndex:)]) {
            [self.delegate pageControl:self didSelectPageIndex:itemView.tag-100];
        }
    }
}

@end
