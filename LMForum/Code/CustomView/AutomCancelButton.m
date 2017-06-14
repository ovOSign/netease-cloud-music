//
//  AutomCancelButton.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/20.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "AutomCancelButton.h"
@interface AutomCancelButton(){
    NSTimer *buttonTimer;
}
@end

@implementation AutomCancelButton

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
        if(!buttonTimer){
            buttonTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerMethod) userInfo:nil repeats:NO];
        }
}

-(void)timerMethod{
    self.highlighted = NO;
    [buttonTimer invalidate];
    buttonTimer = nil;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    if (buttonTimer) {
        [buttonTimer invalidate];
        buttonTimer = nil;
       [super touchesEnded:touches withEvent:event];
    }
    self.highlighted = NO;
}
@end
