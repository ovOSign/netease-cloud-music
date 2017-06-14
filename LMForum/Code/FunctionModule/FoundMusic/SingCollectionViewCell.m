//
//  SingCollectionViewCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/25.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "SingCollectionViewCell.h"

@interface SingCollectionViewCell(){
    UIImageView *rightTopView;
    UIImageView *rightTopImgView;
}


@end

#define SingIndicatorPadding 5

@implementation SingCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
        
        rightTopView = [[UIImageView alloc] init];
        rightTopView.translatesAutoresizingMaskIntoConstraints = NO;
        [rightTopView setImage:[UIImage imageNamed:@"cm2_list_cover_top"]];
        [self.imgView addSubview:rightTopView];
        
        self.rightTopLabel= [[UILabel alloc] init];
        self.rightTopLabel.textColor = [UIColor whiteColor];
        self.rightTopLabel.font = Font(H4);
        self.rightTopLabel.text = @"0";
        self.rightTopLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [rightTopView addSubview:self.rightTopLabel];
        
        
        rightTopImgView = [[UIImageView alloc] init];
        rightTopImgView.translatesAutoresizingMaskIntoConstraints = NO;
        [rightTopImgView setImage:[UIImage imageNamed:@"cm2_list_detail_icn_music"]];
        [rightTopView addSubview:rightTopImgView];
        
        //左下角
        self.personImgView = [[UIImageView alloc] init];
        self.personImgView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.personImgView setImage:[UIImage imageNamed:@"cm2_list_person"]];
        [self.imgView addSubview:self.personImgView];
        
        self.darenImgView = [[UIImageView alloc] init];
        self.darenImgView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.darenImgView setImage:[UIImage imageNamed:@"cm2_icn_daren_letter"]];
        [self.imgView addSubview:self.darenImgView];
        
        self.personLabel= [[UILabel alloc] init];
        self.personLabel.textColor = [UIColor whiteColor];
        self.personLabel.font = Font(H4);
        self.personLabel.text = @"未知";
        self.personLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.imgView addSubview:self.personLabel];
        
        
    }
    return self;
}

-(void)setupCellSingView{
 
    //rigthTopView
    //     UIImage *image = [UIImage imageNamed:@"cm2_list_cover_top"];
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:rightTopView.image.size.height+5]];
    
    //rightTopLabel
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightTopLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rightTopView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightTopLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightTopView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-2]];
    
    //rightTopImgView
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopImgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rightTopView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopImgView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.rightTopLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopImgView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:rightTopImgView.image.size.width]];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopImgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:rightTopImgView.image.size.height]];
    
    //左下角
    //personImg
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.personImgView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant: SingIndicatorPadding]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.personImgView  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-SingIndicatorPadding]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.personImgView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:self.personImgView.image.size.width]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.personImgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:self.personImgView.image.size.height]];
    
    //personlabel
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.personLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:SingIndicatorPadding]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.personLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.personImgView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.personLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.personImgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:SingIndicatorPadding]];
    
    //darenImgView
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.darenImgView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.personLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant: SingIndicatorPadding]];
    
     [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.darenImgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.personImgView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.darenImgView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:self.darenImgView.image.size.width]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.darenImgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:self.darenImgView.image.size.height]];
    [self _setupCellSingView];
    
}
-(void)_setupCellSingView{
    
    
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

@end
