//
//  SingCollectionViewCell.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/25.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *imgView;

@property(nonatomic, strong)UILabel *describeLabel;

@property(nonatomic, strong)UILabel *rightTopLabel;

@property(nonatomic, strong)UILabel *personLabel;

@property(nonatomic, strong)UIImageView *darenImgView;

@property(nonatomic, strong)UIImageView *personImgView;

-(void)setupCellSingView;

@end





