//
//  SingMenuHeaderCellTableViewCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/25.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "SingMenuHeaderCell.h"

@interface SingMenuHeaderCell()

@property(nonatomic, strong)UIImageView *imgView;

@property(nonatomic, strong)UIImageView *bestView;

@property(nonatomic, strong)UILabel *bestLabel;

@property(nonatomic, strong)UILabel *describeLabel;

@property(nonatomic, strong)UIImageView *rightImage;

@end

#define SingMenuHeaderCellIndicatorPadding 12*W_SCALE
#define SingMenuHeaderCellPadding 8*W_SCALE

@implementation SingMenuHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.translatesAutoresizingMaskIntoConstraints = NO;
        _imgView.clipsToBounds=YES;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.c.yinyuetai.com/others/frontPageRec/161219/0/-M-f83414f548534448281d8b453d85a403_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
        [self addSubview:_imgView];
        
        
        _bestView = [[UIImageView alloc] init];
        _bestView.contentMode = UIViewContentModeScaleAspectFill;
        _bestView.translatesAutoresizingMaskIntoConstraints = NO;
        _bestView.image = [UIImage imageNamed:@"cm2_lists_icn_best"];
        _bestView.clipsToBounds=YES;
        [self addSubview:_bestView];
        
        
        _bestLabel = [[UILabel alloc] init];
        _bestLabel.textColor = colorBlack;
        _bestLabel.text = @"精品歌单";
        _bestLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_bestLabel];
        
        
        
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = colorGray1;
        _describeLabel.font = Font(H5);
        _describeLabel.text = @"一人一首华语好声音【男人篇】";
        _describeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_describeLabel];
        
        
        
        _rightImage = [[UIImageView alloc] init];
        _rightImage.contentMode = UIViewContentModeScaleAspectFill;
        _rightImage.translatesAutoresizingMaskIntoConstraints = NO;
        _rightImage.image = [UIImage imageNamed:@"cm2_lists_icn_arr"];
        _rightImage.clipsToBounds=YES;
        [self addSubview:_rightImage];
        
        [self _setLayoutConstraint];
    }
    return self;
}

-(void)_setLayoutConstraint{
    //imageView
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_imgView]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_imgView)]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imgView]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_imgView)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imgView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_imgView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    //_bestView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bestView  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:SingMenuHeaderCellIndicatorPadding]];
    
     [self addConstraint:[NSLayoutConstraint constraintWithItem:_bestView  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_imgView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bestView  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:_bestView.image.size.width]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bestView  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:_bestView.image.size.height]];
    
    //_bestLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bestLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_bestView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bestLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bestView attribute:NSLayoutAttributeRight multiplier:1.0 constant:SingMenuHeaderCellPadding]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bestLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_bestView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    
    //_describeLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_describeLabel  attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_imgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:SingMenuHeaderCellIndicatorPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_describeLabel  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_imgView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:SingMenuHeaderCellIndicatorPadding]];
    
    
    //_rightImage
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImage  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-SingMenuHeaderCellIndicatorPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImage  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImage  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:_rightImage.image.size.width]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImage  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:_rightImage.image.size.height]];
    
}

+ (CGFloat)cellHeight{
    return S_WIDTH*0.25;
}

@end
