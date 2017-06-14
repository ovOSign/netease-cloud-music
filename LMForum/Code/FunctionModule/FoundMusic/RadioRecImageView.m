//
//  RadioRecImageView.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/4.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "RadioRecImageView.h"
@interface RadioRecImageView()

@property(nonatomic, strong)UIImageView *imagePlay;

@end

#define RadioIndicatorPadding 5

@implementation RadioRecImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imagePlay = [[UIImageView alloc] init];
        _imagePlay.translatesAutoresizingMaskIntoConstraints = NO;
        [_imagePlay setImage:[UIImage imageNamed:@"cm2_act_list_play"]];
        [self addSubview:_imagePlay];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imagePlay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeRight multiplier:1 constant:-RadioIndicatorPadding]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imagePlay  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-RadioIndicatorPadding]];
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _imagePlay = [[UIImageView alloc] init];
        _imagePlay.translatesAutoresizingMaskIntoConstraints = NO;
        [_imagePlay setImage:[UIImage imageNamed:@"cm2_act_list_play"]];
        [self addSubview:_imagePlay];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imagePlay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeRight multiplier:1 constant:-RadioIndicatorPadding]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imagePlay  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-RadioIndicatorPadding]];
        

    }
    return self;
}

@end
