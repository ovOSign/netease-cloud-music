//
//  LAccountCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/24.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LAccountCell.h"

@implementation LAccountCell

-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
       
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.accountImageView.layer.cornerRadius=40*S_WIDTH/400;
}

@end
