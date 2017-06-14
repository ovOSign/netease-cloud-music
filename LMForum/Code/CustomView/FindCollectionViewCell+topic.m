//
//  FindCollectionViewCell+topic.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/19.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "FindCollectionViewCell+topic.h"

@implementation FindCollectionViewCell (topic)
-(void)setupCellTopicView{
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
    
    
    
    UIImageView *leftTopView = [[UIImageView alloc] init];
    leftTopView.translatesAutoresizingMaskIntoConstraints = NO;
    [leftTopView setImage:[UIImage imageNamed:@"cm2_chat_icn_topic"]];
    [self.imgView addSubview:leftTopView];
    
    //leftTopView
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:leftTopView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:leftTopView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:5]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:leftTopView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:leftTopView.image.size.width]];
    
    [self.imgView addConstraint:[NSLayoutConstraint constraintWithItem:leftTopView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:leftTopView.image.size.height]];
    
    
    [self _setupCellTopicView];
    
}


-(void)_setupCellTopicView{
    
    
    //imgView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeWidth multiplier:0.58 constant:0.0]];
    
    //describeLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.describeLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
}

@end
