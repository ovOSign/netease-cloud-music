//
//  LStatusCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/29.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LStatusCell.h"
#import "LCGUtilities.h"

@implementation LStatusProfileView{
    BOOL _trackingTouch;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = S_WIDTH;
        frame.size.height = kWBCellProfileHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    _avatarView = [UIImageView new];
    _avatarView.frame = CGRectMake(kWBCellPadding, kWBCellPadding + 3, 40*W_SCALE, 40*W_SCALE);
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarView.layer.cornerRadius = 40*W_SCALE*.5;
    _avatarView .image = [UIImage imageNamed:@"d8cb8a14fb901a0b8bd445.jpg"];
    _avatarView.clipsToBounds = YES;
    _avatarView.userInteractionEnabled = YES;
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
    _avatarBadgeView.frame = CGRectMake(CGRectGetMaxX(_avatarView.frame)-10, CGRectGetMaxY(_avatarView.frame)-14, 14, 14);
    _avatarBadgeView.contentMode = UIViewContentModeScaleAspectFit;
    _avatarBadgeView.image = [UIImage imageNamed:@"cm2_icn_v"];
    [self addSubview:_avatarBadgeView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = Font(kWBCellNameFontSize);
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_avatarView.frame)+kWBCellNamePaddingLeft, _avatarView.frame.origin.y, kWBCellNameWidth, _avatarView.frame.size.height*.6);
    _nameLabel.lineBreakMode = NSLineBreakByClipping;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = RGB(21,85,149,1);
    _nameLabel.userInteractionEnabled = YES;
    [self addSubview:_nameLabel];
    
    _actionLabel = [UILabel new];
    _actionLabel.lineBreakMode = NSLineBreakByClipping;
    _actionLabel.textAlignment = NSTextAlignmentLeft;
    _actionLabel.text = @"分享单曲：";
    _actionLabel.textColor = RGB(103,104,104,1);
    _actionLabel.font = Font(kWBCellNameFontSize);
    [self addSubview:_actionLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_avatarView.frame)+kWBCellNamePaddingLeft, CGRectGetMaxY(_avatarView.frame)-_avatarView.frame.size.height*.3, 100, _avatarView.frame.size.height*.3);
    _timeLabel.font = Font(H6);
    _timeLabel.textColor = RGB(134,133,133,1);
    _timeLabel.text = @"3月28日";
    [self addSubview:_timeLabel];
    
    
    [_nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userActon:)]];
    
    [_avatarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userActon:)]];
    
    
    return self;
}

-(void)userActon:(UITapGestureRecognizer*)gesture{
    if ([self.cell.delegate respondsToSelector:@selector(cell:didClickProfileView:)]){
        [self.cell.delegate cell:self.cell didClickProfileView:self];
    }
}

//- (void)setVerifyType:(WBUserVerifyType)verifyType {
//    _verifyType = verifyType;
//    switch (verifyType) {
//        case WBUserVerifyTypeStandard: {
//            _avatarBadgeView.hidden = NO;
//            _avatarBadgeView.image = [WBStatusHelper imageNamed:@"avatar_vip"];
//        } break;
//        case WBUserVerifyTypeClub: {
//            _avatarBadgeView.hidden = NO;
//            _avatarBadgeView.image = [WBStatusHelper imageNamed:@"avatar_grassroot"];
//        } break;
//        default: {
//            _avatarBadgeView.hidden = YES;
//        } break;
//    }
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    _trackingTouch = NO;
//    UITouch *t = touches.anyObject;
//    CGPoint p = [t locationInView:_avatarView];
//    if (CGRectContainsPoint(_avatarView.bounds, p)) {
//        _trackingTouch = YES;
//    }
//    p = [t locationInView:_nameLabel];
//    if (CGRectContainsPoint(_nameLabel.bounds, p) && _nameLabel.textLayout.textBoundingRect.size.width > p.x) {
//        _trackingTouch = YES;
//    }
//    if (!_trackingTouch) {
//        [super touchesBegan:touches withEvent:event];
//    }
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    if (!_trackingTouch) {
//        [super touchesEnded:touches withEvent:event];
//    } else {
//        if ([_cell.delegate respondsToSelector:@selector(cell:didClickUser:)]) {
//            [_cell.delegate cell:_cell didClickUser:_cell.statusView.layout.status.user];
//        }
//    }
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    if (!_trackingTouch) {
//        [super touchesCancelled:touches withEvent:event];
//    }
//}



@end


@implementation LStatusCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kWBCellContentWidth;
        frame.size.height = kWBCellCarHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kWBCellCarPadding, kWBCellCarPadding, frame.size.height-2*kWBCellCarPadding, frame.size.height-2*kWBCellCarPadding)];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setImage:[UIImage imageNamed:@"cm2_act_list_play"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"cm2_act_list_pause"] forState:UIControlStateSelected];
    _button.frame = CGRectMake(0,0,_imageV.frame.size.width,_imageV.frame.size.height);
    [_imageV addSubview:_button];
    
    _songNamelabel = [UILabel new];
    _songNamelabel.frame = CGRectMake(10+CGRectGetMaxX(_imageV.frame), kWBCellCarPadding, kWBCellContentWidth - 2*kWBCellCarPadding -_imageV.frame.size.width-LRetweetCellPadding*2, _imageV.frame.size.height*.5);
    _songNamelabel.font = Font(kWBCellTextFontRetweetSize);
    _songNamelabel.textColor = RGB(31,31,31,1);
    [self addSubview:_songNamelabel];
    
    _singerlabel = [UILabel new];
    _singerlabel.frame = CGRectMake(10+CGRectGetMaxX(_imageV.frame), CGRectGetMaxY(_songNamelabel.frame), kWBCellContentWidth - 2*kWBCellCarPadding -_imageV.frame.size.width-LRetweetCellPadding*2, _imageV.frame.size.height*.5);
    _singerlabel.font = Font(kWBCellTextFontRetweetSize);
    _singerlabel.textColor = RGB(134,133,133,1);
    [self addSubview:_singerlabel];
    
    [self addSubview:_imageV];

    return self;
}


@end



@implementation LStatusToolbarView
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = S_WIDTH;
        frame.size.height = kWBCellToolbarHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setImage:[UIImage imageNamed:@"cm2_act_icn_praise"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"cm2_act_icn_praised"] forState:UIControlStateSelected];
    _likeButton.frame = CGRectMake(self.frame.size.width-3*kWBCellToolbarButtonWidth-kWBCellNamePaddingLeft, 0, kWBCellToolbarButtonWidth, self.frame.size.height);
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setImage:[UIImage imageNamed:@"cm2_act_icn_cmt"] forState:UIControlStateNormal];
    _commentButton.frame = CGRectMake(self.frame.size.width-2*kWBCellToolbarButtonWidth-kWBCellNamePaddingLeft, 0, kWBCellToolbarButtonWidth, self.frame.size.height);
    
    //转发
    _repostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_repostButton setImage:[UIImage imageNamed:@"cm2_act_icn_share"] forState:UIControlStateNormal];
    _repostButton.frame = CGRectMake(self.frame.size.width-kWBCellToolbarButtonWidth-kWBCellNamePaddingLeft, 0, kWBCellToolbarButtonWidth, self.frame.size.height);
    

    [_likeButton setTitle:@"点赞" forState:UIControlStateNormal];
    [_likeButton setTitleColor:RGB(103,104,104,1) forState:UIControlStateNormal];
    _likeButton.titleLabel.font = Font(H5);
    _likeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    [_likeButton addTarget:self action:@selector(zanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [_commentButton setTitleColor:RGB(103,104,104,1) forState:UIControlStateNormal];
    _commentButton.titleLabel.font = Font(H5);
    _commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    [_commentButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    

    [_repostButton setTitle:@"转发" forState:UIControlStateNormal];
    [_repostButton setTitleColor:RGB(103,104,104,1) forState:UIControlStateNormal];
    _repostButton.titleLabel.font = Font(H5);
    _repostButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    [_repostButton addTarget:self action:@selector(repostAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_likeButton];
    [self addSubview:_commentButton];
    [self addSubview:_repostButton];

    return self;
}

- (void)setWithLayout:(LStatusLayout *)layout {
    _likeButton.selected = layout.status.attitudesStatus == 0 ? false :true;

    [_likeButton setTitle:layout.status.attitudesCount == 0 ? @"点赞" : [NSString stringWithFormat:@"%d",layout.status.attitudesCount] forState:UIControlStateNormal];
    [_commentButton setTitle: layout.status.commentsCount == 0 ? @"评论" : [NSString stringWithFormat:@"%d",layout.status.commentsCount] forState:UIControlStateNormal];
    [_repostButton setTitle: layout.status.repostsCount == 0 ? @"转发" : [NSString stringWithFormat:@"%d",layout.status.repostsCount] forState:UIControlStateNormal];
}


- (void)repostAction:(UIButton*)button{
    if ([self.cell.delegate respondsToSelector:@selector(cell:didClickrepostButton:)]){
        [self.cell.delegate cell:self.cell didClickrepostButton:button];
    }
}

- (void)commentAction:(UIButton*)button{
    if ([self.cell.delegate respondsToSelector:@selector(cell:didClickcommentButton:)]){
        [self.cell.delegate cell:self.cell didClickcommentButton:button];
    }
}

- (void)zanAction:(UIButton*)button{
    if ([self.cell.delegate respondsToSelector:@selector(cell:didClickzanButton:)]){
        [self.cell.delegate cell:self.cell didClickzanButton:button];
    }
}

@end

@implementation LStatusLinkToolbarView
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = S_WIDTH;
        frame.size.height = kWBCellLinkToolbarHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    
    _likeLabel = [UILabel new];
    _likeLabel.font = Font(kWBCellTextFontRetweetSize);
    _likeLabel.textColor = RGB(103,104,104,1);
    _likeLabel.text = @"赞：";
    _likeLabel.center = CGPointMake(kWBCellPadding, frame.size.height*.25);
    [_likeLabel sizeToFit];
    [self addSubview:_likeLabel];
    
    //图片
    NSMutableArray *picViews = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        LImageView *imageView = [LImageView new];
        imageView.frame = CGRectMake(CGRectGetMaxX(_likeLabel.frame)+(kWBCellPadding+frame.size.height*0.6)*i, frame.size.height*.2, frame.size.height*0.6, frame.size.height*0.6);
        imageView.hidden = YES;
        imageView.clipsToBounds = YES;
        imageView.exclusiveTouch = YES;
        imageView.layer.cornerRadius = frame.size.height*0.3;
        [picViews addObject:imageView];
        [self addSubview:imageView];
    }
    _picViews = picViews;
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setImage:[UIImage imageNamed:@"cm2_act_icn_praise"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"cm2_act_icn_praised"] forState:UIControlStateSelected];
    [_likeButton setTitle:@"赞" forState:UIControlStateNormal];
    [_likeButton setTitleColor:RGB(103,104,104,1) forState:UIControlStateNormal];
    _likeButton.titleLabel.font = Font(H5);
    _likeButton.layer.borderWidth = 1;
    _likeButton.layer.borderColor = RGB(211, 210, 213, 1).CGColor;
    _likeButton.layer.cornerRadius = 5*W_SCALE;
    _likeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4*W_SCALE);
    _likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, -4*W_SCALE, 0, 0);
    _likeButton.frame = CGRectMake(frame.size.width-60*W_SCALE-kWBCellPadding, (frame.size.height - 25*W_SCALE)*.5, 60*W_SCALE, 25*W_SCALE);
    [_likeButton addTarget:self action:@selector(zanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeButton];
    
    return self;
}

- (void)setWithLayout:(LStatusLayout *)layout {
    if (!layout.status.linkPicIds || [layout.status.linkPicIds count] == 0) {
        _likeLabel.text = @"喜欢，就赞一下吧";
         [_likeLabel sizeToFit];
    }
    _likeButton.selected = layout.status.attitudesStatus == 0 ? false :true;
}
- (void)zanAction:(UIButton*)button{
    if ([self.cell.delegate respondsToSelector:@selector(cell:didClickzanButton:)]){
        [self.cell.delegate cell:self.cell didClickzanButton:button];
    }
}

@end


@implementation LStatusView
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
    
    //菜单
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_menuButton setImage:[UIImage imageNamed:@"cm2_list_icn_arr_open"] forState:UIControlStateNormal];
    _menuButton.frame = CGRectMake(S_WIDTH-25*W_SCALE-kWBCellNamePaddingLeft, kWBCellPadding + 3, 25*W_SCALE, 25*W_SCALE);
    [_contentView addSubview:_menuButton];
    
    //关注
    _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_followButton setImage:[UIImage imageNamed:@"cm2_act_btn_icn_add"] forState:UIControlStateNormal];
    [_followButton setTitle:@"关注" forState:UIControlStateNormal];
    [_followButton setTitleColor:RGB(199, 37, 38, 1) forState:UIControlStateNormal];
    _followButton.titleLabel.font = Font(H5);
    _followButton.layer.borderWidth = 1;
    _followButton.layer.borderColor = RGB(211, 210, 213, 1).CGColor;
    _followButton.layer.cornerRadius = 5*W_SCALE;
    _followButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4*W_SCALE);
    _followButton.imageEdgeInsets = UIEdgeInsetsMake(0, -4*W_SCALE, 0, 0);
    _followButton.frame = CGRectMake(S_WIDTH-25*W_SCALE-2*kWBCellNamePaddingLeft-60*W_SCALE, kWBCellPadding + 3, 60*W_SCALE, 25*W_SCALE);
    [_contentView addSubview:_followButton];
    
    
    
    //个人资料
    _profileView = [LStatusProfileView new];
    [_contentView addSubview:_profileView];
    
    //文字
    _textLabel = [KILabel new];
    _textLabel.numberOfLines = 0;
    _textLabel.tintColor = RGB(21,85,149,1);
    _textLabel.textColor = RGB(31,31,31,1);
    [_contentView addSubview:_textLabel];
    
    //转发容器
    _retweetBackgroundView = [UIView new];
    _retweetBackgroundView.backgroundColor = RGB(234,235,236,1);
    [_contentView addSubview:_retweetBackgroundView];
    
    //转发文字
    _retweetTextLabel = [KILabel new];
    _retweetTextLabel.tintColor = RGB(21,85,149,1);
    _retweetTextLabel.numberOfLines = 0;
    _retweetTextLabel.textColor = RGB(83,83,83,1);
    KILinkTapHandler tapHandler = ^(KILabel *label, NSString *string, NSRange range) {
        if ([self.cell.delegate respondsToSelector:@selector(cell:didClickAtName:)]){
            [self.cell.delegate cell:self.cell didClickAtName:self];
        }
        
    };
    _retweetTextLabel.userHandleLinkTapHandler = tapHandler;
    [_contentView addSubview:_retweetTextLabel];
    
    //图片
    __weak typeof(self) weakSelf = self;
    NSMutableArray *picViews = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        LImageView *imageView = [LImageView new];
        imageView.bounds = CGRectMake(0, 0, 100, 100);
        imageView.hidden = YES;
        imageView.clipsToBounds = YES;
        imageView.exclusiveTouch = YES;
        imageView.userInteractionEnabled = YES;
        [picViews addObject:imageView];
        [_contentView addSubview:imageView];
        imageView.touchBlock = ^(LImageView *view, LGestureRecognizerState state, NSSet *touches, UIEvent *event) {
            if (![weakSelf.cell.delegate respondsToSelector:@selector(cell:didClickImageAtIndex:)]) return;
            if (state == LGestureRecognizerStateEnded) {
                UITouch *touch = touches.anyObject;
                CGPoint p = [touch locationInView:view];
                if (CGRectContainsPoint(view.bounds, p)) {
                    [weakSelf.cell.delegate cell:weakSelf.cell didClickImageAtIndex:i];
                }
            }
        };
    }
    _picViews = picViews;
    
    //卡片
    _cardView = [LStatusCardView new];
    _cardView.backgroundColor = RGB(234,235,236,1);
    [_contentView addSubview:_cardView];
    [_cardView addTarget:self action:@selector(cardHandleTap:) forControlEvents:UIControlEventTouchUpInside];
    
    //底部bar
    _toolbarView = [LStatusToolbarView new];
    [_contentView addSubview:_toolbarView];

    return self;
}

- (void)setLayout:(LStatusLayout *)layout {
    _layout = layout;
    CGRect frame = self.frame;
    frame.size.height = layout.height;
    self.frame = frame;
    //个人资料
    _contentView.frame = CGRectMake(0, 0, S_WIDTH, layout.height);
    _profileView.nameLabel.frame =(CGRect){_profileView.nameLabel.frame.origin,layout.nameSize};
    _profileView.nameLabel.text = layout.status.name;
    _profileView.actionLabel.frame = CGRectMake(CGRectGetMaxX( _profileView.nameLabel.frame)+kWBCellNamePaddingLeft,  _profileView.avatarView.frame.origin.x, S_WIDTH*0.3, 24);
    if ([layout.status.profileImageURL isKindOfClass:[NSURL class]]) {
        [_profileView.avatarView sd_setImageWithURL:layout.status.profileImageURL];
    }else if([layout.status.profileImageURL isKindOfClass:[NSString class]]) {
        [_profileView.avatarView setImage:[UIImage imageNamed:layout.status.profileImageURL]];
    }else{
        [_profileView.avatarView setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
    }
    _profileView.timeLabel.text = layout.status.createdTime;
    if (layout.status.retweetedStatus) {
           _profileView.actionLabel.text = @"转发：";
    }
 
    
    //文本
    _textLabel.frame = CGRectMake(CGRectGetMinX(_profileView.nameLabel.frame), CGRectGetMaxY(_profileView.frame), kWBCellContentWidth, layout.textHeight);
    
    NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:layout.status.text attributes:_layout.textAttribute];
    _textLabel.attributedText = attributeText;
    
    
    _retweetBackgroundView.hidden = YES;
    _retweetTextLabel.hidden = YES;
    if (layout.picHeight == 0 && layout.retweetPicHeight == 0) {
        [self _hideImageViews];
    }
    
    _toolbarView.frame = CGRectMake(0, _contentView.frame.size.height-_toolbarView.frame.size.height-kWBCellPadding, _toolbarView.frame.size.width, _toolbarView.frame.size.height);
    
    
    //优先级是 转发->图片->卡片
    if (layout.retweetHeight > 0) {
        _retweetBackgroundView.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), CGRectGetMaxY(_textLabel.frame), _textLabel.frame.size.width, layout.retweetHeight);
        _retweetBackgroundView.hidden = NO;
        
        
        _retweetTextLabel.frame = CGRectMake(CGRectGetMinX(_retweetBackgroundView.frame)+LRetweetCellPadding, CGRectGetMinY(_retweetBackgroundView.frame), _retweetBackgroundView.frame.size.width-2*LRetweetCellPadding, layout.retweetTextHeight);
        NSString *retweetedText = [NSString stringWithFormat:@"@%@ 分享单曲：%@",layout.status.retweetedStatus.name,layout.status.retweetedStatus.text];
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:retweetedText attributes:_layout.retweetAttribute];
        _retweetTextLabel.attributedText = attributeStr;
        _retweetTextLabel.hidden = NO;
        if (layout.retweetPicHeight > 0) {
            [self _setImageViewWithTop:CGRectGetMaxY(_retweetTextLabel.frame) isRetweet:YES];
        } else {
            [self _hideImageViews];
        }
        
        _cardView.frame = CGRectMake(_retweetBackgroundView.frame.origin.x+LRetweetCellPadding, _contentView.frame.size.height-_toolbarView.frame.size.height-2*kWBCellPadding-kWBCellCarHeight, _retweetBackgroundView.frame.size.width-LRetweetCellPadding*2, kWBCellCarHeight);
        _cardView.backgroundColor = [UIColor whiteColor];
        
    } else if (layout.picHeight > 0) {
        [self _setImageViewWithTop:CGRectGetMaxY(_textLabel.frame)+ kWBCellPaddingPic isRetweet:NO];
        _cardView.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), _contentView.frame.size.height-_toolbarView.frame.size.height-2*kWBCellPadding-kWBCellCarHeight, _textLabel.frame.size.width, kWBCellCarHeight);
         _cardView.backgroundColor = RGB(234,235,236,1);
        
    } else if (layout.cardHeight > 0) {
        _cardView.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), _contentView.frame.size.height-_toolbarView.frame.size.height-2*kWBCellPadding-kWBCellCarHeight, _textLabel.frame.size.width, kWBCellCarHeight);
         _cardView.backgroundColor = RGB(234,235,236,1);
    }
     [self _setCard:layout];
     [_toolbarView setWithLayout:layout];
}

- (void)setDetailLayout:(LStatusLayout *)layout{
    _layout = layout;
    CGRect frame = self.frame;
    frame.size.height = layout.dheight;
    self.frame = frame;
    //个人资料
    _contentView.frame = CGRectMake(0, 0, S_WIDTH, layout.dheight);
    _profileView.nameLabel.frame =(CGRect){_profileView.nameLabel.frame.origin,layout.nameSize};
    _profileView.nameLabel.text = layout.status.name;
    _profileView.actionLabel.frame = CGRectMake(CGRectGetMaxX( _profileView.nameLabel.frame)+kWBCellNamePaddingLeft,  _profileView.avatarView.frame.origin.x, S_WIDTH*0.3, 24);
    if ([layout.status.profileImageURL isKindOfClass:[NSURL class]]) {
        [_profileView.avatarView sd_setImageWithURL:layout.status.profileImageURL];
    }else if([layout.status.profileImageURL isKindOfClass:[NSString class]]) {
        [_profileView.avatarView setImage:[UIImage imageNamed:layout.status.profileImageURL]];
    }else{
        [_profileView.avatarView setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
    }
    _profileView.timeLabel.text = layout.status.createdTime;
    
    //文本
    _textLabel.frame = CGRectMake(CGRectGetMinX(_profileView.avatarView.frame), CGRectGetMaxY(_profileView.frame), kWBCellDetailContentWidth, layout.dtextHeight);
    
    NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:layout.status.text attributes:_layout.textAttribute];
    _textLabel.attributedText = attributeText;
    
    
    _retweetBackgroundView.hidden = YES;
    _retweetTextLabel.hidden = YES;
    if (layout.picHeight == 0 && layout.retweetPicHeight == 0) {
        [self _hideImageViews];
    }
    
    [_toolbarView removeFromSuperview];
    [_linkToolbarView removeFromSuperview];
    _linkToolbarView = [LStatusLinkToolbarView new];
    _linkToolbarView.cell = _toolbarView.cell;
    [_linkToolbarView setWithLayout:_layout];
    [self addSubview:_linkToolbarView];
    _linkToolbarView.frame = CGRectMake(0, _contentView.frame.size.height-_toolbarView.frame.size.height-kWBCellPadding, _linkToolbarView.frame.size.width, _linkToolbarView.frame.size.height);
    
    
    //优先级是 转发->图片->卡片
    if (layout.retweetHeight > 0) {
        _retweetBackgroundView.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), CGRectGetMaxY(_textLabel.frame), _textLabel.frame.size.width, layout.dretweetHeight);
        _retweetBackgroundView.hidden = NO;
        
        
        _retweetTextLabel.frame = CGRectMake(CGRectGetMinX(_retweetBackgroundView.frame)+LRetweetCellPadding, CGRectGetMinY(_retweetBackgroundView.frame), _retweetBackgroundView.frame.size.width-2*LRetweetCellPadding, layout.dretweetTextHeight);
        
        NSString *retweetedText = [NSString stringWithFormat:@"@%@ 分享单曲：%@",layout.status.retweetedStatus.name,layout.status.retweetedStatus.text];
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:retweetedText attributes:_layout.retweetAttribute];
        _retweetTextLabel.attributedText = attributeStr;
        _retweetTextLabel.hidden = NO;
        if (layout.retweetPicHeight > 0) {
            [self _setDetailImageViewWithTop:CGRectGetMaxY(_retweetTextLabel.frame) isRetweet:YES];
        } else {
            [self _hideImageViews];
        }
        
        _cardView.frame = CGRectMake(_retweetBackgroundView.frame.origin.x+LRetweetCellPadding, _contentView.frame.size.height-_toolbarView.frame.size.height-2*kWBCellPadding-kWBCellCarHeight, _retweetBackgroundView.frame.size.width-LRetweetCellPadding*2, kWBCellCarHeight);
        _cardView.backgroundColor = [UIColor whiteColor];
        
    } else if (layout.picHeight > 0) {
        [self _setDetailImageViewWithTop:CGRectGetMaxY(_textLabel.frame)+ kWBCellPaddingPic isRetweet:NO];
        
        _cardView.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), _contentView.frame.size.height-_toolbarView.frame.size.height-2*kWBCellPadding-kWBCellCarHeight, _textLabel.frame.size.width, kWBCellCarHeight);
        
    } else if (layout.cardHeight > 0) {
        _cardView.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), _contentView.frame.size.height-_toolbarView.frame.size.height-2*kWBCellPadding-kWBCellCarHeight, _textLabel.frame.size.width, kWBCellCarHeight);
       
    }
     [self _setCard:layout];
    if([_layout.status.linkPicIds count]>0){
        [self _setLikeImageView];
    }
    
}

-(void)_setCard:(LStatusLayout *)layout{
     MusicModel *model = layout.status.retweetedStatus.shareMusic;
    if (!model) {
        model = layout.status.shareMusic;
    }
    if (model) {
        if ([model.icon isKindOfClass:[NSURL class]]) {
            [_cardView.imageV sd_setImageWithURL:model.icon];
        }else if([model.icon isKindOfClass:[NSString class]]) {
            [_cardView.imageV setImage:[UIImage imageNamed:model.icon]];
        }else{
            [_cardView.imageV setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
        }
        _cardView.songNamelabel.text = model.name;
        _cardView.singerlabel.text = model.singer;
    }else{
       [_cardView.imageV setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
        _cardView.songNamelabel.text = @"未知";
        _cardView.singerlabel.text = @"未知";
    }
    _cardView.button.selected = layout.status.playing || layout.status.retweetedStatus.playing;
}

- (void)_hideImageViews {
    for (UIImageView *imageView in _picViews) {
        imageView.hidden = YES;
    }
}

- (void)_setImageViewWithTop:(CGFloat)imageTop isRetweet:(BOOL)isRetweet {
    CGSize picSize = isRetweet ? _layout.retweetPicSize : _layout.picSize;
    NSArray *pics = isRetweet ? _layout.status.retweetedStatus.pics : _layout.status.pics;
    int picsCount = (int)pics.count;
    
    CGFloat padding = isRetweet ?  LRetweetCellPadding: 0;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = _picViews[i];
        if (i >= picsCount) {
            imageView.hidden = YES;
        } else {
            CGPoint origin = {0};
            switch (picsCount) {
                case 1: {
                    origin.x = CGRectGetMinX(_textLabel.frame)+padding;
                    origin.y = imageTop;
                } break;
                default: {
                    origin.x = CGRectGetMinX(_textLabel.frame)+padding + (i % 2) * (picSize.width + kWBCellPaddingPic);
                    origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                } break;
            }
            imageView.frame = (CGRect){.origin = origin, .size = picSize};
            imageView.hidden = NO;
            [imageView.layer removeAnimationForKey:@"contents"];
            imageView.backgroundColor = [UIColor redColor];
            id pic = pics[i];
            if([pic isKindOfClass:[WBPicture class]]){
              [imageView sd_setImageWithURL:((WBPicture*)pic).bmiddle.url];
            }else if([pic isKindOfClass:[UIImage class]]){
                [imageView setImage:pic];
            }
            
        }
    }
}

- (void)_setDetailImageViewWithTop:(CGFloat)imageTop isRetweet:(BOOL)isRetweet {
    CGSize picSize = isRetweet ? _layout.dretweetPicSize : _layout.dpicSize;
    NSArray *pics = isRetweet ? _layout.status.retweetedStatus.pics : _layout.status.pics;
    int picsCount = (int)pics.count;
    
    CGFloat padding = isRetweet ?  LRetweetCellPadding: 0;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = _picViews[i];
        if (i >= picsCount) {
            imageView.hidden = YES;
        } else {
            CGPoint origin = {0};
            switch (picsCount) {
                case 1: {
                    origin.x = CGRectGetMinX(_textLabel.frame)+padding;
                    origin.y = imageTop;
                } break;
                default: {
                    origin.x = CGRectGetMinX(_textLabel.frame)+padding + (i % 2) * (picSize.width + kWBCellPaddingPic);
                    origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                } break;
            }
            imageView.frame = (CGRect){.origin = origin, .size = picSize};
            imageView.hidden = NO;
            [imageView.layer removeAnimationForKey:@"contents"];
            imageView.backgroundColor = [UIColor redColor];
            id pic = pics[i];
            if([pic isKindOfClass:[WBPicture class]]){
                [imageView sd_setImageWithURL:((WBPicture*)pic).bmiddle.url];
            }else if([pic isKindOfClass:[UIImage class]]){
                [imageView setImage:pic];
            }
            
        }
    }
}

- (void)_setLikeImageView{
    NSMutableArray *users = _layout.status.linkPicIds;
    for (int i = 0; i < [users count]; i++) {
        UIImageView *imageView = _linkToolbarView.picViews[i];
        User *u = users[i];
        imageView.hidden = NO;
        if([u.avatar isKindOfClass:[NSURL class]]){
            [imageView sd_setImageWithURL:u.avatar];
        }else if([u.avatar isKindOfClass:[NSString class]]){
            [imageView setImage:[UIImage imageNamed:u.avatar]];
        }else if([u.avatar isKindOfClass:[UIImage class]]){
            [imageView setImage:u.avatar];
        }
    }
}

-(void)cardHandleTap:(UIButton*) button{
    if ([self.cell.delegate respondsToSelector:@selector(cell:didClickMusicCard:)]){
        [self.cell.delegate cell:self.cell didClickMusicCard:self.cardView];
    }
}

@end

@implementation LStatusCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _statusView = [LStatusView new];
    _statusView.cell = self;
    _statusView.profileView.cell = self;
    _statusView.cardView.cell = self;
    _statusView.toolbarView.cell = self;
    [self.contentView addSubview:_statusView];
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return self;
}


- (void)setLayout:(LStatusLayout *)layout {
    _statusView.layout = layout;

}

- (void)setDetailLayout:(LStatusLayout *)layout{
    [layout layoutDetail];
    [_statusView setDetailLayout:layout];
    
}

@end
