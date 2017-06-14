//
//  SingMenuCell.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/25.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingMenuCell : UITableViewCell

@property (strong, nonatomic) NSMutableArray *dataArray;

-(void)reloadData;

+ (CGFloat)cellHeight;

@end
