//
//  RecommendViewHeaderCell.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/18.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendViewHeaderCell : UITableViewCell

@property(nonatomic, strong)NSArray *carouseMakes;

+ (CGFloat)cellHeight;
@end
