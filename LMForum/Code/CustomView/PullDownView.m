//
//  PullDownView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/18.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "PullDownView.h"
@interface PullDownView()

@property(nonatomic, strong)UIImageView *imageView;

@end

#define PullDownViewMargin 12*H_SCALE

@implementation PullDownView

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage*)image text:(NSString*)text{
   self =  [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] init];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_label];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_label]-margin-|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"margin" : @(PullDownViewMargin)}
                                                                       views:NSDictionaryOfVariableBindings(_label)]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_imageView]"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"margin" : @(PullDownViewMargin)}
                                                                       views:NSDictionaryOfVariableBindings(_imageView)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:image.size.width]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:image.size.height]];
        [self.label setText:text];
        [self.imageView setImage:image];
    }
    return self;
}


//-(void)setImage:(UIImage *)image{
//    _image = image;
//
//
//    
//    [self updateConstraintsIfNeeded];
//}
@end
