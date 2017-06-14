//
//  BannerMenuCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/2.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerMenuCell : UITableViewCell
@property(nonatomic, strong)NSArray *carouseMakes;
+ (CGFloat)cellHeight;
@end
