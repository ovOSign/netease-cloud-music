//
//  UserHeadCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/5/15.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "UserHeadCell.h"
@interface UserHeadCell()<UIScrollViewDelegate>

@end

@implementation UserHeadCell

-(void)layoutSubviews{
    [super layoutSubviews];
    self.avater.layer.cornerRadius=40*S_WIDTH/400-1;
    self.avater.layer.borderWidth = 2;
    self.avater.layer.borderColor = [UIColor whiteColor].CGColor;
}


-(void)setUser:(User *)user{
    _user = user;
    if ([user.avatar isKindOfClass:[NSURL class]]) {
        [_avater sd_setImageWithURL:user.avatar ];
    }else if([user.avatar  isKindOfClass:[NSString class]]) {
        [_avater setImage:[UIImage imageNamed:user.avatar]];
    }else{
        [_avater setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
    }
    _name.text = user.name;
    _lv.text = [NSString stringWithFormat:@"%d",user.lv];
    [ _sex setImage:[UIImage imageNamed:user.sex == 0 ? @"cm2_pro_icn_boy" :@"cm2_pro_icn_girl"]];
    
    _guanzhuCount.text = [NSString stringWithFormat:@"%d",user.guanzhuCount];
    _fansiCount.text = [NSString stringWithFormat:@"%d",user.fansCount];
    _dongtaiCount.text = [NSString stringWithFormat:@"%d",user.dongtaiCount];
    if(user.jieshao)_jianjieLabel.text = user.jieshao;
    _information.text = [NSString stringWithFormat:@"%@, %@ %@",user.dizhi,user.niandai,user.xingzuo];
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        CGFloat ratio=(scrollView.contentOffset.x)/scrollView.frame.size.width;
    if ([self.delegate respondsToSelector:@selector(cell:scroll:)]){
        [self.delegate cell:self scroll:ratio];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x == 0){
        [_pageControl setCurrentPage:0];
    }else if(scrollView.contentOffset.x == scrollView.frame.size.width){
        [_pageControl setCurrentPage:1];
    }
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
