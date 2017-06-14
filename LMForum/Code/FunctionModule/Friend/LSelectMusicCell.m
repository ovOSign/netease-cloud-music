//
//  LSelectMusicCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/6.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LSelectMusicCell.h"

@interface LSelectMusicCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *singerAlbum;
@end
@implementation LSelectMusicCell
-(void)setModel:(MusicModel *)model{
    _model = model;
    [_icon setImage:[UIImage imageNamed:model.icon]];
    [_songName setText:model.name];
    [_singerAlbum setText:model.singer];
}
@end
