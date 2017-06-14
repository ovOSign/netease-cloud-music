//
//  SingMenuHeaderView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/25.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "SingMenuHeaderView.h"

@interface SingMenuHeaderView()

@property(nonatomic, strong)UIImageView *lineImgView;

@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UIButton *sortButton;

@end

#define SingMenuHeaderViewPadding 8*W_SCALE

@implementation SingMenuHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lineImgView = [[UIImageView alloc] init];
        _lineImgView.contentMode = UIViewContentModeScaleAspectFill;
        _lineImgView.image = [UIImage imageNamed:@"cm2_icn_title_line"];
        _lineImgView.translatesAutoresizingMaskIntoConstraints = NO;
        _lineImgView.clipsToBounds=YES;
        [self addSubview:_lineImgView];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = colorBlack;
        _titleLabel.font = Font(H1);
        _titleLabel.text = @"全部歌曲";
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleLabel];
        
        _sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sortButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_sortButton setTitleColor:colorBlack forState:UIControlStateNormal];
        [_sortButton setTitleColor:colorBlack forState:UIControlStateHighlighted];
        [_sortButton setImage:[UIImage imageNamed:@"cm2_discover_btn_slt"] forState:UIControlStateNormal];
        [_sortButton setImage:[UIImage imageNamed:@"cm2_discover_btn_slt_prs"] forState:UIControlStateHighlighted];
        _sortButton.titleLabel.font = Font(_sortButton.imageView.image.size.height*0.4);
        [_sortButton setTitle:@"选择分类" forState:UIControlStateNormal];
        [self addSubview:_sortButton];
        
        [self _setLayoutConstraint];
    }
    return self;
}

-(void)_setLayoutConstraint{
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_lineImgView]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_lineImgView)]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineImgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineImgView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:_lineImgView.image.size.width]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineImgView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:_lineImgView.image.size.height]];
    
    //_titleLabel
     [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_lineImgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:SingMenuHeaderViewPadding]];
    
    //_sortButton
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_sortButton]-margin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_sortButton)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_sortButton]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_sortButton)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_sortButton  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:_sortButton.imageView.frame.size.width]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_sortButton  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:_sortButton.imageView.frame.size.height]];
    
    CGSize size = [CommonUtils sizeForString:_sortButton.titleLabel.text Font:_sortButton.titleLabel.font ConstrainedToSize:self.frame.size LineBreakMode:NSLineBreakByWordWrapping];
    _sortButton.titleEdgeInsets = UIEdgeInsetsMake(0, -size.width-(cellMargin+SingMenuHeaderViewPadding), 0,0);
    
    
}
@end
