//
//  LLrcCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LLrcCell.h"

@implementation LLrcCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        _lrcLabel = [[UILabel alloc] init];
        _lrcLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _lrcLabel.textColor = RGB(210, 210, 210, 0.8);
        _lrcLabel.textAlignment = NSTextAlignmentCenter;
        _lrcLabel.text = @"aaaaaa";
        [self.contentView addSubview:_lrcLabel];
        
        

        [self addSubview:_lrcLabel];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_lrcLabel]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_lrcLabel)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_lrcLabel]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_lrcLabel)]];
    }
    return self;
}


@end
