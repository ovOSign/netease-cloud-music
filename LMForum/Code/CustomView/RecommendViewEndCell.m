//
//  RecommendViewEndCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/20.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "RecommendViewEndCell.h"

@interface RecommendViewEndCell(){
    NSTimer *buttonTimer;
}
@property(nonatomic, assign)id target;
@property(nonatomic)SEL action;
@end

@implementation RecommendViewEndCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews{
    _label = [[UILabel alloc] init];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.font = Font(H4);
    _label.textColor = colorGray;
    _label.text =@"现在可以根据个人喜好，自由调整首页栏目顺序啦～";
    [self addSubview:_label];
    
    _button = [AutomCancelButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"调整栏目顺序" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithPatternImage:MAINIMAGECOLOR] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_button setBackgroundImage:[UIImage imageNamed:@"cm2_set_btn_sign_ad"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"cm2_set_btn_sign_ad_prs"] forState:UIControlStateHighlighted];
    _button.translatesAutoresizingMaskIntoConstraints = NO;
    _button.titleLabel.font = Font(H4);
    _button.contentEdgeInsets = UIEdgeInsetsMake(6*W_SCALE, 6*W_SCALE, 6*W_SCALE, 6*W_SCALE);
    [self addSubview:_button];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_label]"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:@{@"margin" : @(cellMargin)}
                                                                               views:NSDictionaryOfVariableBindings(_label)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label]-margin-[_button]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin" : @(cellMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_label,_button)]];
    [_button addTarget:self action:@selector(buttonUpInsideActon:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addTarget:(id)target action:(SEL)action{
    self.target = target;
    self.action = action;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
-(void)buttonUpInsideActon:(UIButton*)button{

    if ([self.target respondsToSelector:self.action]) {
         [self.target performSelector:self.action];
    }

}


+ (CGFloat)cellHeight{
    return S_WIDTH*0.25;
}
@end
