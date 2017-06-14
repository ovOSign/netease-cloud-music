//
//  LRectMusicCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/5/16.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LRectMusicCell.h"

@implementation LRectMusicCell

-(void)setModel:(MusicModel *)model{
    _model = model;
    [_song setText:model.name];
    [_singer setText:model.singer];
}
- (IBAction)moreAction:(id)sender {
}

@end
