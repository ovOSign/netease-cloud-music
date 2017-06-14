//
//  LImageView.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/6.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LGestureRecognizerState) {
    LGestureRecognizerStateBegan, ///< gesture start
    LGestureRecognizerStateMoved, ///< gesture moved
    LGestureRecognizerStateEnded, ///< gesture end
    LGestureRecognizerStateCancelled, ///< gesture cancel
};
@interface LImageView : UIImageView

@property (nonatomic, copy) void (^touchBlock)(LImageView *view, LGestureRecognizerState state, NSSet *touches, UIEvent *event);
@property (nonatomic, copy) void (^longPressBlock)(LImageView *view, CGPoint point);

@end
