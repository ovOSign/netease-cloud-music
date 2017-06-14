//
//  LCollectionViewCell.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/19.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LCollectionViewCellType) {
    LCollectionViewCellTypeRecmd = 0,
    
    LCollectionViewCellTypeMv,
    
    LCollectionViewCellTypeNewest,
    
    LCollectionViewCellTypeExclusive,
    
    LCollectionViewCellTypeRadio,
};

@interface FindCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UILabel *describeLabel;

@property(nonatomic, strong)UILabel *singerLabel;

@property(nonatomic, strong)UILabel *radioNameLabel;

@property(nonatomic, strong)UIImageView *imgView;

@property(nonatomic, strong)UILabel *rightTopLabel;

@end
