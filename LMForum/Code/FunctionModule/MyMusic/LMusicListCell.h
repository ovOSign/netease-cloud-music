//
//  LMusicListCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/23.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMusicColumModel.h"
@interface LMusicListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

@property (weak, nonatomic) IBOutlet UILabel *itemName;

@property (weak, nonatomic) IBOutlet UILabel *numText;

@property(nonatomic, strong) MyMusicColumModel *model;

@end
