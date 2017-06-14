//
//  LSongMenuCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/24.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMusicColumMenuModel.h"
@interface LSongMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *numText;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *personName;

@property(nonatomic, strong) MyMusicColumMenuModel *model;

@end
