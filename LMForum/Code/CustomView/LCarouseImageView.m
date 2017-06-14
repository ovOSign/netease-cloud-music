//
//  LTagView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/13.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "LCarouseImageView.h"

@interface LCarouseImageView()

@property(nonatomic, strong)UILabel *tagLabel;

@property(nonatomic, strong)UIImageView *tagView;

@end

#define LCarouseTagFont Font(12)

#define LCarouseTagInternalYPadding 3

#define LCarouseTagInternalXPadding 15

#define LCarouseTagMargin 5

@implementation LCarouseImageView

-(void)setTagName:(NSString *)tagName model:(LTagViewModel)model{
    
    if (_tagView) [_tagView removeFromSuperview];
    
    [self addSubview:self.tagView];
    
     CGSize size = [CommonUtils sizeForString:tagName Font:LCarouseTagFont ConstrainedToSize:self.frame.size LineBreakMode:NSLineBreakByWordWrapping];
     CGFloat tagViewWidth =  size.width+LCarouseTagInternalXPadding*2;
     CGFloat tagViewHeight = size.height+LCarouseTagInternalYPadding*2;
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:tagViewWidth]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:tagViewHeight]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_tagView]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_tagView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tagView]-margin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin" : @(LCarouseTagMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_tagView)]];
    _tagLabel.text = tagName;
    switch (model) {
        case LTagViewModelNormal: {
            UIImage *image = [UIImage imageNamed:@"cm2_di_icn_label_blue"];
            image = [image stretchableImageWithLeftCapWidth:image.size.width topCapHeight:0];
            [_tagView setImage:image];
       
        }
        break;
        case LTagViewModelHot: {
            UIImage *image = [UIImage imageNamed:@"cm2_di_icn_label_red"];
            image = [image stretchableImageWithLeftCapWidth:image.size.width topCapHeight:0];
            [_tagView setImage:image];
        }
        break;
        default: break;
    }
    [self layoutIfNeeded];
    
}

-(UIView *)tagView{
    if (!_tagView) {
        _tagView = [[UIImageView alloc] init];
        _tagView.translatesAutoresizingMaskIntoConstraints = NO;
        _tagLabel = [[UILabel alloc]init];
        _tagLabel.textColor = [UIColor whiteColor];
        _tagLabel.font = LCarouseTagFont;
        _tagLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_tagView addSubview:_tagLabel];
        
        [_tagView addConstraint:[NSLayoutConstraint constraintWithItem:_tagLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_tagView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [_tagView addConstraint:[NSLayoutConstraint constraintWithItem:_tagLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_tagView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

    }
    
    return _tagView;
}


@end
