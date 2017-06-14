//
//  ColumSetFootView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/22.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "ColumSetFootView.h"

@implementation ColumSetFootView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       self.backgroundColor= MAINIBACKGROUNDCOLOR;
        UIButton *recoverButton = [UIButton buttonWithType:UIButtonTypeCustom];

        NSDictionary *normalDct = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName :Font(H4),NSUnderlineColorAttributeName:colorGray2,NSForegroundColorAttributeName:colorGray2};
        
        NSDictionary *highDct = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName :Font(H4),NSUnderlineColorAttributeName:colorGray2,NSForegroundColorAttributeName:colorGray2,NSBackgroundColorAttributeName:RGB(191, 191, 191, .5)};

        [recoverButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"恢复默认排序" attributes:normalDct] forState:UIControlStateNormal];
        
        [recoverButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"恢复默认排序" attributes:highDct] forState:UIControlStateHighlighted];
        CGSize size = [CommonUtils sizeForString:@"恢复默认排序" Font:Font(H4) ConstrainedToSize:CGSizeMake(200, 200) LineBreakMode:NSLineBreakByWordWrapping];
        recoverButton.translatesAutoresizingMaskIntoConstraints = NO;
        recoverButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:recoverButton];
    
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[recoverButton]-padding-|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"padding":@(-size.height)}
                                                                       views:NSDictionaryOfVariableBindings(recoverButton)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:recoverButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        
        [recoverButton addTarget:self action:@selector(recoverAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *v in [self subviews]) {
        if ([v isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")]) {
            [v removeFromSuperview];
        }
        
    }
}

-(void)recoverAction:(id)sender{
    
}
    
@end
