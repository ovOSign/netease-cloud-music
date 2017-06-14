//
//  RankOfCloudCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/4.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "RankOfCloudCell.h"
@interface RankOfCloudCell()
@property (weak, nonatomic) IBOutlet UIImageView *rankBgImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *rankTitle;
@property (weak, nonatomic) IBOutlet UILabel *rankUpdateTitle;
@property (weak, nonatomic) IBOutlet UILabel *firstItem;
@property (weak, nonatomic) IBOutlet UILabel *secondItem;
@property (weak, nonatomic) IBOutlet UILabel *thirdItem;

@end

@implementation RankOfCloudCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setBean:(RankBean *)bean{
    _bean = bean;
    switch (_bean.model) {
        case LRankTypeUp:
            _rankBgImageVIew.image = [UIImage imageNamed:@"cm2_list_rank_bg_up.jpg"];
            _rankTitle.text = @"飙升榜";
            _rankUpdateTitle.text = @"每天更新";
            break;
        case LRankTypeHot:
            _rankBgImageVIew.image = [UIImage imageNamed:@"cm2_list_rank_bg_hot.jpg"];
            _rankTitle.text = @"热歌榜";
            _rankUpdateTitle.text = @"每周四更新";
            break;
        case LRankTypeOriginal:
            _rankBgImageVIew.image = [UIImage imageNamed:@"cm2_list_rank_bg_original.jpg"];
            _rankTitle.text = @"原创榜";
            _rankUpdateTitle.text = @"每周四更新";
            break;
        case LRankTypeNew:
            _rankBgImageVIew.image = [UIImage imageNamed:@"cm2_list_rank_bg_new.jpg"];
            _rankTitle.text = @"新歌榜";
            _rankUpdateTitle.text = @"每天更新";
            break;
            
        default:
            break;
    }
    _firstItem.text = _bean.firstItem;
    _secondItem.text = _bean.secondItem;
    _thirdItem.text = _bean.thirdItem;
}

@end
