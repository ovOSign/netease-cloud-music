//
//  LStatusCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/29.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LStatusLayout.h"
#import "KILabel.h"
@class LStatusCell;
@interface LStatusProfileView : UIView
@property (nonatomic, strong) UIImageView *avatarView; ///< 头像
@property (nonatomic, strong) UIImageView *avatarBadgeView; ///< 徽章
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *actionLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
//@property (nonatomic, strong) UIButton *arrowButton;
//@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, assign) LUserVerifyType verifyType;
@property (nonatomic, weak) LStatusCell *cell;
@end


@interface LStatusCardView : UIButton
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) UILabel *songNamelabel;
@property (nonatomic, strong) UILabel *singerlabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) LStatusCell *cell;
@end

@interface LStatusToolbarView : UIView
@property (nonatomic, strong) UIButton *repostButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *repostLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *likeLabel;

@property (nonatomic, weak) LStatusCell *cell;

- (void)setWithLayout:(LStatusLayout *)layout;

@end

@interface LStatusLinkToolbarView : UIView

@property (nonatomic, strong) UILabel *likeLabel;

@property (nonatomic, strong) NSArray<UIImageView *> *picViews;

@property (nonatomic, strong) UIButton *likeButton;    // 菜单按钮

@property (nonatomic, weak) LStatusCell *cell;


- (void)setWithLayout:(LStatusLayout *)layout;

@end


@interface LStatusView : UIView
@property (nonatomic, strong) UIView *contentView;              // 容器
@property (nonatomic, strong) LStatusProfileView *profileView; // 用户资料
@property (nonatomic, strong) KILabel *textLabel;               // 文本
@property (nonatomic, strong) NSArray<UIImageView *> *picViews;      // 图片
@property (nonatomic, strong) UIView *retweetBackgroundView;    //转发容器
@property (nonatomic, strong) KILabel *retweetTextLabel;        // 转发文本
@property (nonatomic, strong) LStatusCardView *cardView;       // 卡片
@property (nonatomic, strong) UILabel *sourceLabel;             //来源
@property (nonatomic, strong) LStatusToolbarView *toolbarView; // 工具栏
@property (nonatomic, strong) LStatusLinkToolbarView *linkToolbarView; // 点赞栏
@property (nonatomic, strong) UIImageView *vipBackgroundView;   // VIP 自定义背景
@property (nonatomic, strong) UIButton *menuButton;             // 菜单按钮
@property (nonatomic, strong) UIButton *followButton;           // 关注按钮

@property (nonatomic, strong) LStatusLayout *layout;
@property (nonatomic, weak) LStatusCell *cell;

- (void)setDetailLayout:(LStatusLayout *)layout;

@end


@protocol LStatusCellDelegate;

@interface LStatusCell : UITableViewCell

@property (nonatomic, weak) id<LStatusCellDelegate> delegate;

@property (nonatomic, strong) LStatusView *statusView;

- (void)setLayout:(LStatusLayout *)layout;

- (void)setDetailLayout:(LStatusLayout *)layout;

@end

@protocol LStatusCellDelegate <NSObject>

@optional
- (void)cell:(LStatusCell *)cell didClickImageAtIndex:(NSUInteger)index;
- (void)cell:(LStatusCell *)cell didClickMusicCard:(LStatusCardView*)cardView;
- (void)cell:(LStatusCell *)cell didClickrepostButton:(UIButton*)button;
- (void)cell:(LStatusCell *)cell didClickcommentButton:(UIButton*)button;
- (void)cell:(LStatusCell *)cell didClickzanButton:(UIButton*)button;
- (void)cell:(LStatusCell *)cell didClickProfileView:(UIView*)view;
- (void)cell:(LStatusCell *)cell didClickAtName:(UIView*)view;
@end
