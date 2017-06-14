//
//  LPicInputView.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/3.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LPicInputView.h"

@implementation LPicInputView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //图片
        NSMutableArray *picViews = [NSMutableArray new];
        UIImage *image = [UIImage imageNamed:@"cm2_act_addmusic"];
        CGFloat picMargin = (frame.size.width-4*image.size.width-2*cellMargin)/3;
        for (int i = 0; i < 4; i++) {
            UIImageView *imageView = [UIImageView new];
            imageView.frame = CGRectMake(cellMargin+(image.size.width+picMargin)*i, (frame.size.height-image.size.height)*.5, image.size.width, image.size.height);
            imageView.hidden = YES;
            imageView.exclusiveTouch = YES;
            [picViews addObject:imageView];
            [self addSubview:imageView];
        }
        _picViews = picViews;
        UIImageView *defShowImgView = _picViews[0];
        defShowImgView.hidden = NO;
        [defShowImgView setImage:image];
        
        
    }
    return self;
}

@end
