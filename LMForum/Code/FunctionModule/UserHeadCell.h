//
//  UserHeadCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/5/15.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserHeadCellDelegate;

@interface UserHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *avater;
@property (weak, nonatomic) IBOutlet UILabel *dongtaiCount;

@property (weak, nonatomic) IBOutlet UILabel *fansiCount;

@property (weak, nonatomic) IBOutlet UILabel *guanzhuCount;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *lv;

@property (weak, nonatomic) IBOutlet UIImageView *sex;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *jianjieLabel;
@property (weak, nonatomic) IBOutlet UILabel *information;
@property (weak, nonatomic) id<UserHeadCellDelegate> delegate;
@property (strong,nonatomic)         User *user;

@end

@protocol UserHeadCellDelegate <NSObject>

@optional
-(void)cell:(UserHeadCell*)cell scroll:(CGFloat)ratio;
@end
