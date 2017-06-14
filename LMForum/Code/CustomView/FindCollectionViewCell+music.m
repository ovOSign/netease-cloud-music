//
//  FindCollectionViewCell+Recmd.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/19.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "FindCollectionViewCell+music.h"
@interface FindCollectionViewCell()

@end

@implementation FindCollectionViewCell (music)

-(void)setupCellMusicView{
    self.imgView = [[UIImageView alloc] init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgView.clipsToBounds=YES;
    [self addSubview:self.imgView];
    
    self.describeLabel = [[UILabel alloc] init];
    self.describeLabel.numberOfLines = 2;
    self.describeLabel.font = Font(H3);
    self.describeLabel.textColor = colorBlack;
    self.describeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.describeLabel];
    
    
    
    UIImageView *rightTopView = [[UIImageView alloc] init];
    rightTopView.translatesAutoresizingMaskIntoConstraints = NO;
    [rightTopView setImage:[UIImage imageNamed:@"cm2_list_cover_top"]];
    [self.imgView addSubview:rightTopView];
    
    self.rightTopLabel= [[UILabel alloc] init];
    self.rightTopLabel.textColor = [UIColor whiteColor];
    self.rightTopLabel.font = Font(H4);
    self.rightTopLabel.text = @"0";
    self.rightTopLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [rightTopView addSubview:self.rightTopLabel];
    
    UIImageView *rightTopImgView = [[UIImageView alloc] init];
    rightTopImgView.translatesAutoresizingMaskIntoConstraints = NO;
    [rightTopImgView setImage:[UIImage imageNamed:@"cm2_list_detail_icn_music"]];
    [rightTopView addSubview:rightTopImgView];
    
    
    //rigthTopView
    //     UIImage *image = [UIImage imageNamed:@"cm2_list_cover_top"];
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:rightTopView attribute:NSLayoutAttributeWidth multiplier:.18 constant:0.0]];
    
    //rightTopLabel
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightTopLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rightTopView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightTopLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightTopView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-2]];
    
    //rightTopImgView
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopImgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rightTopView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopImgView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.rightTopLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopImgView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:rightTopImgView.image.size.width]];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopImgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:rightTopImgView.image.size.height]];
    
    
    [self _setupCellMusicView];
    
}

-(void)setupCellMusicViewWithSinger{
    self.imgView = [[UIImageView alloc] init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgView.clipsToBounds=YES;
    [self addSubview:self.imgView];
    
    self.describeLabel = [[UILabel alloc] init];
    self.describeLabel.numberOfLines = 1;
    self.describeLabel.font = Font(H3);
    self.describeLabel.textColor = colorBlack;
    self.describeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.describeLabel];
    
    self.singerLabel = [[UILabel alloc] init];
    self.singerLabel.numberOfLines = 1;
    self.singerLabel.font = Font(H3);
    self.singerLabel.textColor = colorGray;
    self.singerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.singerLabel];
    
    [self _setupCellMusicViewWithSinger];
}

-(void)_setupCellMusicView{
    
 
    //imgView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    //describeLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
}

-(void)_setupCellMusicViewWithSinger{
    //imgView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    //describeLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    //singerLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.singerLabel  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.describeLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.singerLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.singerLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
}

@end
