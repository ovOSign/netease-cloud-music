//
//  RecommendViewButtonsCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/19.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "RecommendViewButtonsCell.h"
#import "HorizonButtonsView.h"
@interface RecommendViewButtonsCell()

@property(nonatomic, strong)HorizonButtonsView *buttonsView;

@property(nonatomic, strong)UIView *bottomTrim;

@end

#define CellBottomTrimHeight 0.5

@implementation RecommendViewButtonsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = MAINIBACKGROUNDCOLOR;
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews{
    _buttonsView = [[HorizonButtonsView alloc] init];
    _buttonsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_buttonsView];
    
    _bottomTrim = [[UIView alloc] init];
    _bottomTrim.translatesAutoresizingMaskIntoConstraints = NO;
    _bottomTrim.backgroundColor = RGB(186, 186, 186, 1);
    [self addSubview:_bottomTrim];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_buttonsView]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_buttonsView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_buttonsView]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings( _buttonsView)]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomTrim]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_bottomTrim)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomTrim(height)]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"height" : @(CellBottomTrimHeight)}
                                                                   views:NSDictionaryOfVariableBindings(_bottomTrim)]];
}
+ (CGFloat)cellHeight{
    return S_WIDTH*0.30;
}
@end
