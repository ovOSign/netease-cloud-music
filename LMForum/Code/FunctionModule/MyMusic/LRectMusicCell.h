//
//  LRectMusicCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/5/16.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRectMusicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *song;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (nonatomic, strong) MusicModel *model;
@end
