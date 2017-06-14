//
//  LTableView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/24.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "LTableView.h"
@interface LTableView()

@property(nonatomic, strong)UIImageView *imageView;

@property(nonatomic, strong)UILabel *loadLabel;

@end

@implementation LTableView

#define LTableViewInternalPadding 25*H_SCALE


-(void)initNoData{
    [self.imageView startAnimating];
    [self addSubview:self.imageView];
    [self addSubview:self.loadLabel];
    
}

-(void)reloadData
{
    [super reloadData];
    
    if (self.indexPathsForVisibleRows.count>0) {
       [self cleanNoData];
    }else{
       [self initNoData];
    }
}

-(void)cleanNoData{
    [_imageView stopAnimating];
    [_imageView removeFromSuperview];
    [_loadLabel removeFromSuperview];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        CGFloat width=self.frame.size.width;
        CGFloat height=self.frame.size.height;
        UIImage *image = [UIImage imageNamed:@"cm2_list_icn_loading1"];
        _imageView=[[UIImageView alloc] init];
        _imageView.animationImages = @[[UIImage imageNamed:@"cm2_list_icn_loading1"],[UIImage imageNamed:@"cm2_list_icn_loading2"],[UIImage imageNamed:@"cm2_list_icn_loading3"],[UIImage imageNamed:@"cm2_list_icn_loading4"]];
        CGFloat imgWidth = image.size.width;
        CGFloat imgHeight = image.size.height;
        _imageView.frame = (CGRect){CGPointMake((width-imgWidth)*.5, CGRectGetMaxY(self.tableHeaderView.bounds)+height*0.12),CGSizeMake(imgWidth, imgHeight)};
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        _imageView.animationDuration = 1;
    }
    return _imageView;
}

-(UILabel*)loadLabel{
    if (!_loadLabel) {
        CGFloat width=self.frame.size.width;
        _loadLabel = [[UILabel alloc] init];
        _loadLabel.font = Font(H3);
        _loadLabel.text = @"正在加载...";
        _loadLabel.textColor = colorGray1;
        [_loadLabel sizeToFit];
        _loadLabel.layer.position = CGPointMake(width*.5, CGRectGetMaxY(self.imageView.frame)+LTableViewInternalPadding);
    }
    return _loadLabel;
}

-(void)loadFaild{
    [_imageView stopAnimating];
    _loadLabel.text = @"暂无内容";
    [_imageView removeFromSuperview];
}
-(void)stopLoad{
    [self cleanNoData];
}

-(void)startLoad{
    [self initNoData];
}

@end
