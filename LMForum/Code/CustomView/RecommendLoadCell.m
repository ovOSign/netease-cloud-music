//
//  RecommendLoadCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/25.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "RecommendLoadCell.h"
@interface RecommendLoadCell(){
    CGFloat angle;
}

@property(nonatomic, strong)UIImageView *loadingView;

@property(nonatomic, strong)UILabel *loadLabel;

@end

@implementation RecommendLoadCell

#define LTableViewInternalPadding 25*H_SCALE

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.loadingView];
        [self addSubview:self.loadLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layoutFrame];
}

-(void)layoutFrame{
    CGFloat width=self.frame.size.width;
    CGFloat imgWidth = self.loadingView.image.size.width;
    CGFloat imgHeight = self.loadingView.image.size.height;
    
    _loadingView.frame = (CGRect){CGPointMake((width-imgWidth)*.5, self.frame.size.height*0.17),CGSizeMake(imgWidth, imgHeight)};
    [_loadLabel sizeToFit];
    _loadLabel.layer.anchorPoint =  CGPointMake(0.5,0.5);
    _loadLabel.layer.position = CGPointMake(width*.5, CGRectGetMaxY(_loadingView.frame)+LTableViewInternalPadding);
}

-(UIImageView *)loadingView{
    if (!_loadingView) {
        UIImage *image = [CommonUtils addImage:[UIImage imageNamed:@"cm2_discover_icn_start"] toImage:[UIImage imageNamed:@"cm2_discover_icn_start_bg"]];
        _loadingView=[[UIImageView alloc] init];
        _loadingView.image = image;
    }
    return _loadingView;
}

-(UILabel*)loadLabel{
    if (!_loadLabel) {
        _loadLabel = [[UILabel alloc] init];
        _loadLabel.font = Font(H3);
        _loadLabel.text = @"正在为你生产个性化推荐...";
        _loadLabel.textColor = colorGray1;
    }
    return _loadLabel;
}

-(void)startAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10;
//    rotationAnimation.removedOnCompletion = NO;
//    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.loadingView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)stopAnimation{
    [self.loadingView.layer removeAllAnimations];
}

@end
