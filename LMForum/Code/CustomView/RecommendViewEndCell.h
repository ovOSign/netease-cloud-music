//
//  RecommendViewEndCell.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/20.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutomCancelButton.h"
@interface RecommendViewEndCell : UITableViewCell

@property(nonatomic, strong)UILabel *label;

@property(nonatomic, strong)AutomCancelButton *button;

- (void)addTarget:(id)target action:(SEL)action;

+ (CGFloat)cellHeight;

@end

