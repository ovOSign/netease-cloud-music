//
//  LSongMenuHeadView.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/24.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LSongMenuHeadView.h"

@implementation LSongMenuHeadView

-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

-(void)setState:(MenuHeadState)state{
    _state = state;
    switch (state) {
        case MenuHeadStateFold:
            [self fold];
            break;
        case MenuHeadStateDown:
            [self down];
            break;
            
        default:
            break;
    }
}

-(void)fold{
    [self.foldImageView setImage:[UIImage imageNamed:@"cm2_list_icn_arr_fold"]];
}

-(void)down{
    [self.foldImageView setImage:[UIImage imageNamed:@"cm2_list_icn_arr_down"]];
}
@end
