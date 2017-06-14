//
//  RadioRecomendCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/4.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioRecImageView.h"
@interface RadioRecomendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet RadioRecImageView *recImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *describe;

@end
