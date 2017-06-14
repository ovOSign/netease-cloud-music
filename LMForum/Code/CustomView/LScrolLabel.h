//
//  LScrolLabel.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LScrolLabel : UIView

@property(nonatomic, strong)NSString *songName;

@property(nonatomic, strong)NSString *singerName;

@property(nonatomic, strong)UIColor *songColor;

@property(nonatomic, strong)UIColor *singerColor;

-(void)setSongName:(NSString *)songName singer:(NSString *)singerName;

-(void)startScroll;

-(void)resetScroll;

@end
