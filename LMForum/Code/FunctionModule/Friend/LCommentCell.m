//
//  LCommentCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LCommentCell.h"
#import "LCGUtilities.h"
@implementation LCommentStatusProfileView{
    BOOL _trackingTouch;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = S_WIDTH;
        frame.size.height = LComProfileHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    _avatarView = [UIImageView new];
    _avatarView.frame = CGRectMake(LComCellPadding,LComCellTopMargin, LComCellAvatar, LComCellAvatar);
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarView.layer.cornerRadius = LComCellAvatar*.5;
    _avatarView .image = [UIImage imageNamed:@"d8cb8a14fb901a0b8bd445.jpg"];
    _avatarView.clipsToBounds = YES;
    [self addSubview:_avatarView];
    
    CALayer *avatarBorder = [CALayer layer];
    avatarBorder.frame = _avatarView.bounds;
    avatarBorder.borderWidth = CGFloatFromPixel(1);
    avatarBorder.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
    avatarBorder.cornerRadius = _avatarView.frame.size.height / 2;
    avatarBorder.shouldRasterize = YES;
    avatarBorder.rasterizationScale = kScreenScale;
    [_avatarView.layer addSublayer:avatarBorder];
    
    _avatarBadgeView = [UIImageView new];
    _avatarBadgeView.frame = CGRectMake(CGRectGetMaxX(_avatarView.frame)-8, CGRectGetMaxY(_avatarView.frame)-12, 14, 14);
    _avatarBadgeView.contentMode = UIViewContentModeScaleAspectFit;
    _avatarBadgeView.image = [UIImage imageNamed:@"cm2_icn_v"];
    [self addSubview:_avatarBadgeView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = Font(LComCellNameFontSize);
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_avatarView.frame)+LComCellPadding, _avatarView.frame.origin.y, LComCellNameWidth, _avatarView.frame.size.height*.6);
    _nameLabel.text = @"alice";
    _nameLabel.lineBreakMode = NSLineBreakByClipping;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = RGB(31,31,31,1);
    [self addSubview:_nameLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_avatarView.frame)+LComCellPadding, CGRectGetMaxY(_avatarView.frame)-_avatarView.frame.size.height*.3, 100, _avatarView.frame.size.height*.3);
    _timeLabel.font = Font(H6);
    _timeLabel.textColor = RGB(134,133,133,1);
    [self addSubview:_timeLabel];
    
    return self;
}

@end

@implementation LCommentStatusView
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = S_WIDTH;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES;
    
    _contentView = [UIView new];
    _contentView.frame = CGRectMake(0, 0, frame.size.width, 1);
    [self addSubview:_contentView];
    
    
    
    //个人资料
    _profileView = [LCommentStatusProfileView new];
    [_contentView addSubview:_profileView];
    
    //文字
    _textLabel = [KILabel new];
    _textLabel.numberOfLines = 0;
    _textLabel.textColor = RGB(31,31,31,1);
    _textLabel.tintColor = RGB(21,85,149,1);
    [_contentView addSubview:_textLabel];
    
    //转发容器
    _retweetBackgroundView = [UIView new];
    _retweetBackgroundView.backgroundColor = [UIColor whiteColor];
    _retweetBackgroundView.layer.borderWidth = 1;
    _retweetBackgroundView.layer.borderColor = RGB(211, 210, 213, 1).CGColor;
    [_contentView addSubview:_retweetBackgroundView];
    
    //转发文字
    _retweetTextLabel = [KILabel new];
    _retweetTextLabel.tintColor = RGB(21,85,149,1);
    _retweetTextLabel.numberOfLines = 0;
    _retweetTextLabel.textColor = RGB(83,83,83,1);
    [_contentView addSubview:_retweetTextLabel];
    
    
    //点赞
    _linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_linkButton setImage:[UIImage imageNamed:@"cm2_act_icn_praise_sm"] forState:UIControlStateNormal];
    [_linkButton setImage:[UIImage imageNamed:@"cm2_act_icn_praised_sm"] forState:UIControlStateSelected];
    _linkButton.frame = CGRectMake(S_WIDTH-25*W_SCALE-LComCellPadding, LComCellPadding, 25*W_SCALE, 25*W_SCALE);
    [_linkButton addTarget:self action:@selector(zanAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_linkButton];
    
    _linkLabel = [UILabel new];
    _linkLabel.frame =  CGRectMake(S_WIDTH-25*W_SCALE-LComCellPadding-50*W_SCALE, LComCellPadding , 50*W_SCALE, 25*W_SCALE);
    _linkLabel.font = Font(H5);
    _linkLabel.textColor = RGB(134,133,133,1);
    _linkLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_linkLabel];
    
    
    return self;
}

- (void)setLayout:(LCommentLayout *)layout {
    _layout = layout;
    CGRect frame = self.frame;
    frame.size.height = layout.height;
    self.frame = frame;
    
    //个人资料
    _contentView.frame = CGRectMake(0, 0, S_WIDTH, layout.height);
    _profileView.nameLabel.frame =(CGRect){_profileView.nameLabel.frame.origin,layout.nameSize};
    _profileView.nameLabel.text = layout.status.name;
    _profileView.timeLabel.text = layout.status.createdTime;
    if ([layout.status.profileImageURL isKindOfClass:[NSURL class]]) {
        [_profileView.avatarView sd_setImageWithURL:layout.status.profileImageURL];
    }else if([layout.status.profileImageURL isKindOfClass:[NSString class]]) {
        [_profileView.avatarView setImage:[UIImage imageNamed:layout.status.profileImageURL]];
    }else{
        [_profileView.avatarView setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
    }
    
    //文本
    _textLabel.frame = CGRectMake(CGRectGetMinX(_profileView.nameLabel.frame), CGRectGetMaxY(_profileView.frame), LComCellContentWidth, layout.textHeight);
    NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:layout.status.text attributes:_layout.textAttribute];
    _textLabel.attributedText = attributeText;
    
    
    [_linkLabel setText:layout.status.attitudesCount <= 0 ? @"" : [NSString stringWithFormat:@"%d",layout.status.attitudesCount]];
    
     _linkButton.selected = layout.status.attitudesStatus == 0 ? false :true;
    
    _retweetBackgroundView.hidden = YES;
    _retweetTextLabel.hidden = YES;
    
    if (layout.retweetHeight > 0) {
        
        _retweetBackgroundView.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), CGRectGetMaxY(_textLabel.frame), _textLabel.frame.size.width, layout.retweetHeight);
        
        _retweetBackgroundView.hidden = NO;
    
        _retweetTextLabel.frame = CGRectMake(CGRectGetMinX(_retweetBackgroundView.frame)+LRetweetCellPadding, CGRectGetMinY(_retweetBackgroundView.frame), _retweetBackgroundView.frame.size.width-2*LRetweetCellPadding, layout.retweetTextHeight);
        
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:layout.status.linkText attributes:_layout.retweetAttribute];
        _retweetTextLabel.attributedText = attributeStr;
        _retweetTextLabel.hidden = NO;
    }

}

- (void)zanAction:(UIButton*)button{
    if ([self.cell.delegate respondsToSelector:@selector(commentCell:didClickzanButton:)]){
        [self.cell.delegate commentCell:self.cell didClickzanButton:button];
    }
}


@end

@implementation LCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _statusView = [LCommentStatusView new];
    _statusView.cell = self;
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_statusView];
    self.separatorInset = UIEdgeInsetsMake(0,LComCellAvatar*W_SCALE+LComCellPadding*2, 0, 0);
    return self;
}


- (void)setLayout:(LCommentLayout *)layout {
    
    _statusView.layout = layout;
    
}



@end
