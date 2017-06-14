//
//  LCommentCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KILabel.h"
#import "LCommentLayout.h"
@class LCommentCell;
@interface LCommentStatusProfileView : UIView

@property (nonatomic, strong) UIImageView *avatarView; ///< 头像
@property (nonatomic, strong) UIImageView *avatarBadgeView; ///< 徽章
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *cityImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) LUserVerifyType verifyType;

@end

@interface LCommentStatusView : UIView
@property (nonatomic, strong) UIView *contentView;              // 容器

@property (nonatomic, strong) LCommentStatusProfileView *profileView; // 用户资料

@property (nonatomic, strong) KILabel *textLabel;               // 文本

@property (nonatomic, strong) UIView *retweetBackgroundView;    //引用容器

@property (nonatomic, strong) KILabel *retweetTextLabel;        // 引用文本

@property (nonatomic, strong) UIButton *linkButton;           // 点赞按钮

@property (nonatomic, strong) UILabel *linkLabel;

@property (nonatomic, strong) LCommentLayout *layout;

@property (nonatomic, weak) LCommentCell *cell;


@end

@protocol LCommentCellDelegate;

@interface LCommentCell : UITableViewCell

@property (nonatomic, strong) LCommentStatusView *statusView;

@property (nonatomic, weak) id<LCommentCellDelegate> delegate;

- (void)setLayout:(LCommentLayout *)layout;

@end


@protocol LCommentCellDelegate <NSObject>

@optional
- (void)commentCell:(LCommentCell *)cell didClickzanButton:(UIButton*)button;
@end
