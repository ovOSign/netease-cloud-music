//
//  LCommentEmptCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/5/14.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LCommentEmptCell.h"
@interface LCommentEmptCell()

@property(nonatomic, strong)UILabel *label;

@end

@implementation LCommentEmptCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.text = @"还没有评论";
        _label.textColor = RGB(103,104,104,1);
        _label.font = Font(H3);
        [_label sizeToFit];
        [self addSubview:_label];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _label.frame = CGRectMake((self.frame.size.width-_label.frame.size.width)/2, (self.frame.size.height-_label.frame.size.height)/2, _label.frame.size.width, _label.frame.size.height);
}

@end
