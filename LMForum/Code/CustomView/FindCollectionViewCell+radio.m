//
//  FindCollectionViewCell+radio.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/20.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "FindCollectionViewCell+radio.h"
#define RadioIndicatorPadding 5
@implementation FindCollectionViewCell (radio)
-(void)setupCellRadioView{
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
    
    
    
 
    
    self.radioNameLabel = [[UILabel alloc] init];
    self.radioNameLabel.textColor = [UIColor whiteColor];
    self.radioNameLabel.font = Font(H4);
    self.radioNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imgView addSubview:self.radioNameLabel];
    
    UIImageView *rightButtonImgView = [[UIImageView alloc] init];
    rightButtonImgView.translatesAutoresizingMaskIntoConstraints = NO;
    [rightButtonImgView setImage:[UIImage imageNamed:@"cm2_act_list_play"]];
    [self.imgView addSubview:rightButtonImgView];
    
    
    //rightButtonImgView
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightButtonImgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imgView  attribute:NSLayoutAttributeRight multiplier:1 constant:-RadioIndicatorPadding]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightButtonImgView  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-RadioIndicatorPadding]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightButtonImgView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:rightButtonImgView.image.size.width]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:rightButtonImgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:rightButtonImgView.image.size.height]];
    
    
    //radioNameLabel
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.radioNameLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:RadioIndicatorPadding]];
    
     [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.radioNameLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:rightButtonImgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-RadioIndicatorPadding]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:self.radioNameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rightButtonImgView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self _setupCellRadioView];

}
-(void)_setupCellRadioView{
    //imgView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    //describeLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
}
@end
