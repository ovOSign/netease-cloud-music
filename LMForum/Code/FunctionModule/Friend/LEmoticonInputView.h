//
//  LEmoticonInputView.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/3.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WBStatusComposeEmoticonViewDelegate <NSObject>
@optional
- (void)emoticonInputDidTapText:(NSString *)text;
- (void)emoticonInputDidTapBackspace;
- (void)emotionconInputDidSend:(UIButton*)button;
@end

@interface LEmoticonInputView : UIView
@property (nonatomic, weak) id<WBStatusComposeEmoticonViewDelegate> delegate;
+ (instancetype)sharedView;

@end
