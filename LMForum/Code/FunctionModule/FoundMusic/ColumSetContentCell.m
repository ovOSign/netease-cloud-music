//
//  ColumSetContentCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/22.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "ColumSetContentCell.h"

@interface ColumSetContentCell()

@end

@implementation ColumSetContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.textColor = colorBlack;
        _label.font = Font(H3);
        [self addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.textLabel.frame;
    _label.frame = CGRectMake(15, rect.origin.y, rect.size.width, rect.size.height);
}

@end
