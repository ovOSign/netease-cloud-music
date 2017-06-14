//
//  RecommendViewColumnCell.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/19.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RecommendViewColumnCell : UITableViewCell

@property(nonatomic, strong)UIView *bottomTrim;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(RecommendColumnCellType)type;

+ (CGFloat)cellHeight:(RecommendColumnCellType)type;

@end
