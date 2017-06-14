//
//  ColumSetHeaderView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/22.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "ColumSetHeaderView.h"

@implementation ColumSetHeaderView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor= MAINIBACKGROUNDCOLOR;
        self.separatorInset = UIEdgeInsetsZero;
        UIImageView *lightView = [[UIImageView alloc] init];
        lightView.image = [UIImage imageNamed:@"cm2_icn_light"];
        lightView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:lightView];
        
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.text = @"想调整首页栏目的顺序?按住右边的按钮拖动即可";
        label.font = Font(lightView.image.size.height);
        label.textColor = colorGray2;
        [self addSubview:label];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[lightView]"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"margin":@(cellMargin)}
                                                                       views:NSDictionaryOfVariableBindings(lightView)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:lightView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:lightView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:lightView.image.size.width]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:lightView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:lightView.image.size.height]];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lightView]-padding-[label]"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"padding":@(2)}
                                                                       views:NSDictionaryOfVariableBindings(lightView,label)]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:lightView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:lightView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
        
        
        
    }
    return self;
}

@end
