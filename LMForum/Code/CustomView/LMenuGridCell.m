//
//  LMenuGridCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LMenuGridCell.h"
@interface LMenuGridCell()

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIButton *label;

@property (nonatomic) NSLayoutConstraint *imageWidthConstraint;

@property (nonatomic) NSLayoutConstraint *imageHeightConstraint;

@property (nonatomic) NSLayoutConstraint *labelWidthConstraint;

@property (nonatomic) NSLayoutConstraint *labelHeightConstraint;

@end
@implementation LMenuGridCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_imageView];
        
        _label = [UIButton buttonWithType:UIButtonTypeCustom];
        _label.userInteractionEnabled = NO;
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        _label.titleLabel.font = Font(H3);
       
        [_label setTitleColor:RGB(83, 83, 83, 1) forState:UIControlStateNormal];
       
        _label.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_label sizeToFit];
        [self addSubview:_label];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
     
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_imageView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_label)]];
        
        
    }
    return self;
}

-(void)setupCellMenuGridView:(NSString *)imageName title:(NSString*)title{
    
    [self removeConstraint:self.imageWidthConstraint];
    [self removeConstraint:self.imageHeightConstraint];
    [self removeConstraint:self.labelWidthConstraint];
    [self removeConstraint:self.labelHeightConstraint];
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    [_imageView setImage:image];
    
    [_label setTitle:title forState:UIControlStateNormal];
    
     CGSize size = [CommonUtils sizeForString:title Font:Font(H3) ConstrainedToSize:self.frame.size LineBreakMode:NSLineBreakByWordWrapping];
  
    self.imageWidthConstraint =[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:image.size.width];
    self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:image.size.height];
    self.labelWidthConstraint = [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:size.width];
    self.labelHeightConstraint = [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:size.height];
    
    [self addConstraint:self.imageWidthConstraint];
    [self addConstraint:self.imageHeightConstraint];
    [self addConstraint:self.labelWidthConstraint];
    [self addConstraint:self.labelHeightConstraint];
 
    [self updateConstraints];
}

@end
