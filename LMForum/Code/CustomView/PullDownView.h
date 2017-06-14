//
//  PullDownView.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/18.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullDownView : UIView

@property(nonatomic, strong)UIImage *image;
@property(nonatomic, strong)UILabel *label;

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage*)image text:(NSString*)text;
@end
