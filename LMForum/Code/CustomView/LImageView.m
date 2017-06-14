//
//  LImageView.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/6.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LImageView.h"

@implementation LImageView{
    CGPoint _point;
    NSTimer *_timer;
    BOOL _longPressDetected;
}

- (void)startTimer {
    [_timer invalidate];
    _timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(timerFire) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)endTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)timerFire {
    [self touchesCancelled:[NSSet set] withEvent:nil];
    _longPressDetected = YES;
    if (_longPressBlock) _longPressBlock(self, _point);
    [self endTimer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _longPressDetected = NO;
    if (_touchBlock) {
        _touchBlock(self, LGestureRecognizerStateBegan, touches, event);
    }
    if (_longPressBlock) {
        UITouch *touch = touches.anyObject;
        _point = [touch locationInView:self];
        [self startTimer];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, LGestureRecognizerStateMoved, touches, event);
    }
    [self endTimer];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, LGestureRecognizerStateEnded, touches, event);
    }
    [self endTimer];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, LGestureRecognizerStateCancelled, touches, event);
    }
    [self endTimer];
}
@end
