//
//  LPicCell.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/5.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPicCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *gifLable;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;
- (UIView *)snapshotView;
@end
