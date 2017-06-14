//
//  LMusicListCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/23.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LMusicListCell.h"

@implementation LMusicListCell

-(void)setModel:(MyMusicColumModel *)model{
    _model = model;
    self.leftImage.image = [UIImage imageNamed:model.image];
    self.itemName.text = model.itemName;
    self.numText.text = model.num;
}

@end
