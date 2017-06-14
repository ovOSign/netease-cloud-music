//
//  LNearTableViewCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LNearTableViewCell.h"
@interface LNearTableViewCell()
@end

@implementation LNearTableViewCell

-(void)layoutSubviews{
    [super layoutSubviews];
    self.accountImageView.layer.cornerRadius=32*S_WIDTH/400;
}


- (void)setModel:(LNearModel *)model{
    _model = model;
    _song.text = [NSString stringWithFormat:@"[%@] - %@",model.song,model.singer];
    _name.text = model.user.name;
    _time.text = model.time;
    _distance.text = model.distance;
    if ([model.user.avatar isKindOfClass:[NSURL class]]) {
        [_accountImageView sd_setImageWithURL:model.user.avatar];
    }else if([model.user.avatar  isKindOfClass:[NSString class]]) {
        [_accountImageView setImage:[UIImage imageNamed:model.user.avatar]];
    }else{
        [_accountImageView setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
    }
    
   [ _sex setImage:[UIImage imageNamed:model.user.sex == 0 ? @"cm2_icn_boy.png" :@"cm2_icn_girl.png"]];
}


- (IBAction)personAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClicUserButtonOfCell:)]){
        [self.delegate didClicUserButtonOfCell:self];
    }
}
- (IBAction)songAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickMusicButtonOfCell:)]){
        [self.delegate didClickMusicButtonOfCell:self];
    }
}

@end
