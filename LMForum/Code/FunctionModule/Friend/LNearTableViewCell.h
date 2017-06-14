//
//  LNearTableViewCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNearModel.h"
@protocol LNearTableViewCellDelegate;
@interface LNearTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *accountImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *song;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic, weak) id<LNearTableViewCellDelegate> delegate;
@property(nonatomic, strong)LNearModel *model;

@end


@protocol LNearTableViewCellDelegate <NSObject>
@optional
- (void)didClickMusicButtonOfCell:(LNearTableViewCell *)cell ;
- (void)didClicUserButtonOfCell:(LNearTableViewCell *)cell ;
@end
